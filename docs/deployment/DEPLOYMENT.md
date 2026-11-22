# Deployment plan

Use separate development, staging and production environments. Keep environment variables in the hosting provider's secret manager. Deploy only after build, automated checks, database migration review and smoke tests pass. Configure a custom domain and HTTPS before public launch.
