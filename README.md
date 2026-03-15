# PaulPandian.com

Personal site and blog for Paul Balasubramanian — AI & Revenue Leadership.

**Live:** [https://paulpandian.com](https://paulpandian.com)

---

## Quick Start

### Option 1: AWS Amplify (Recommended — Easiest)

1. Push this repo to GitHub
2. Go to [AWS Amplify Console](https://console.aws.amazon.com/amplify/)
3. Click **New App** → **Host web app** → **GitHub**
4. Select this repo, branch: `main`
5. Amplify auto-detects the `amplify.yml` config
6. Deploy → Add custom domain `paulpandian.com`
7. Done. Auto-deploys on every push to `main`.

### Option 2: S3 + CloudFront (More Control)

1. Create S3 bucket named `paulpandian.com` in `us-east-1`
2. Enable static website hosting
3. Set up CloudFront distribution pointing to S3
4. Request ACM certificate for `paulpandian.com` + `*.paulpandian.com`
5. Point Route 53 DNS to CloudFront
6. Deploy with: `./deploy.sh`

### Option 3: GitHub Actions (Automated S3 Deploys)

1. Complete Option 2 setup
2. Add repo secrets:
   - `AWS_ROLE_ARN` — IAM role with S3 + CloudFront permissions
   - `CLOUDFRONT_DISTRIBUTION_ID` — your distribution ID
3. Push to `main` → auto-deploys

---

## Updating the Site

Edit files, push to GitHub. That's it.

- **Amplify:** Auto-deploys in ~30 seconds
- **S3 + GitHub Actions:** Auto-deploys in ~60 seconds
- **Manual:** Run `./deploy.sh`
