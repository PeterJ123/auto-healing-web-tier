# Estimated monthly cost

Region: `ap-southeast-2` / Sydney. This is a review/demo design and the challenge states actual provisioning is optional. Prices are estimates only and should be checked with the AWS Pricing Calculator before production use.

## Low-cost assumptions

- 2 x `t4g.nano` Linux instances, always on.
- 1 x Application Load Balancer with very low traffic.
- No NAT Gateway, no private subnets, no RDS, no EBS beyond small root volumes.
- Free Tier / promotional credits may apply for new accounts.
- Terraform plan review does not incur infrastructure cost if resources are not applied.

## Estimate

| Item | Monthly estimate | Notes |
|---|---:|---|
| EC2 `t4g.nano` x 2 | ~AUD 7-10 | On-demand estimate, region-dependent |
| EBS gp3 root volumes | ~AUD 2-4 | Small default root volumes |
| Application Load Balancer | ~AUD 0-25 | Usually the largest cost; can be covered by eligible AWS Free Tier for evaluation accounts |
| Data transfer | ~AUD 0-2 | Assumes minimal demo traffic |

**Estimated review cost when not applied:** AUD 0.

**Estimated deployed demo cost with eligible free-tier ALB:** approximately AUD 10-16/month.

**Estimated deployed cost without free-tier ALB:** likely above AUD 20/month because ALB hourly charges dominate. In production I would keep the ALB for correctness and resilience; for a strict ultra-low-cost personal demo I would consider a single public instance or DNS failover, but that would not satisfy the N+1 load-balanced requirement as cleanly.
