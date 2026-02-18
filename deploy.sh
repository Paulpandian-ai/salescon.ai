#!/bin/bash
# ============================================
# SalesCon.ai Deploy Script
# Usage: ./deploy.sh
# ============================================

set -e

BUCKET="salescon.ai"
DISTRIBUTION_ID="${CLOUDFRONT_DIST_ID:-}"
SITE_DIR="./public"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${GREEN}🚀 Deploying SalesCon.ai${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━"

# Check AWS CLI
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI not found. Install it: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html"
    exit 1
fi

# Sync all files
echo -e "\n📦 Syncing files to S3..."
aws s3 sync $SITE_DIR s3://$BUCKET \
    --delete \
    --exclude ".git/*" \
    --exclude ".DS_Store" \
    --exclude "*.map"

# Set correct content types and caching
echo -e "\n⚡ Setting cache headers..."

# HTML — short cache (5 min)
aws s3 cp s3://$BUCKET/ s3://$BUCKET/ \
    --recursive \
    --exclude "*" \
    --include "*.html" \
    --cache-control "public, max-age=300, s-maxage=600" \
    --content-type "text/html" \
    --metadata-directive REPLACE \
    --quiet

# XML files
aws s3 cp s3://$BUCKET/sitemap.xml s3://$BUCKET/sitemap.xml \
    --cache-control "public, max-age=86400" \
    --content-type "application/xml" \
    --metadata-directive REPLACE \
    --quiet 2>/dev/null || true

# SVG favicon
aws s3 cp s3://$BUCKET/favicon.svg s3://$BUCKET/favicon.svg \
    --cache-control "public, max-age=604800" \
    --content-type "image/svg+xml" \
    --metadata-directive REPLACE \
    --quiet 2>/dev/null || true

# Invalidate CloudFront cache
if [ -n "$DISTRIBUTION_ID" ]; then
    echo -e "\n🌐 Invalidating CloudFront cache..."
    aws cloudfront create-invalidation \
        --distribution-id $DISTRIBUTION_ID \
        --paths "/*" \
        --query 'Invalidation.Id' \
        --output text
    echo -e "${GREEN}✅ Cache invalidation started${NC}"
else
    echo -e "\n${YELLOW}⚠️  No CLOUDFRONT_DIST_ID set — skipping cache invalidation${NC}"
    echo "   Set it: export CLOUDFRONT_DIST_ID=your_distribution_id"
fi

echo -e "\n${GREEN}✅ Deploy complete!${NC}"
echo -e "   Site: https://salescon.ai"
echo ""
