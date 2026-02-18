# SalesCon.ai

Personal site and blog for Paul Karageorge — AI-driven revenue strategy, ecosystem growth, and the future of sales leadership.

**Live:** [https://salescon.ai](https://salescon.ai)

---

## Quick Start

### Option 1: AWS Amplify (Recommended — Easiest)

1. Push this repo to GitHub
2. Go to [AWS Amplify Console](https://console.aws.amazon.com/amplify/)
3. Click **New App** → **Host web app** → **GitHub**
4. Select this repo, branch: `main`
5. Amplify auto-detects the `amplify.yml` config
6. Deploy → Add custom domain `salescon.ai`
7. Done. Auto-deploys on every push to `main`.

### Option 2: S3 + CloudFront (More Control)

1. Create S3 bucket named `salescon.ai` in `us-east-1`
2. Enable static website hosting
3. Set up CloudFront distribution pointing to S3
4. Request ACM certificate for `salescon.ai` + `*.salescon.ai`
5. Point Route 53 DNS to CloudFront
6. Deploy with: `./deploy.sh`

### Option 3: GitHub Actions (Automated S3 Deploys)

1. Complete Option 2 setup
2. Add repo secrets:
   - `AWS_ROLE_ARN` — IAM role with S3 + CloudFront permissions
   - `CLOUDFRONT_DISTRIBUTION_ID` — your distribution ID
3. Push to `main` → auto-deploys

---

## Project Structure

```
salescon-repo/
├── public/               # All site files (served as-is)
│   ├── index.html        # Landing page
│   ├── 404.html          # Custom 404 page
│   ├── favicon.svg       # Site favicon
│   ├── robots.txt        # Search engine directives
│   └── sitemap.xml       # SEO sitemap
├── .github/
│   └── workflows/
│       └── deploy.yml    # GitHub Actions CI/CD
├── amplify.yml           # AWS Amplify build config
├── deploy.sh             # Manual deploy script
└── README.md
```

## Updating the Site

Edit files in `/public`, push to GitHub. That's it.

- **Amplify:** Auto-deploys in ~30 seconds
- **S3 + GitHub Actions:** Auto-deploys in ~60 seconds
- **Manual:** Run `./deploy.sh`

---

## Roadmap

- [ ] Add blog (Astro or Next.js static)
- [ ] Newsletter integration (Beehiiv / ConvertKit)
- [ ] Podcast page
- [ ] Speaking & advisory page
- [ ] Analytics (Plausible / PostHog)
