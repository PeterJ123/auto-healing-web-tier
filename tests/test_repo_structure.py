from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def read(path):
    return (ROOT / path).read_text(encoding="utf-8")

def test_required_deliverables_exist():
    required = [
        "README.md", "versions.tf", "providers.tf", "main.tf", "variables.tf", "outputs.tf",
        "modules/network/main.tf", "modules/security/main.tf", "modules/load_balancer/main.tf",
        "modules/compute/main.tf", "user-data/web.sh.tftpl", "Dockerfile",
        "diagrams/architecture.mmd", "docs/cost-estimate.md", "docs/terraform-github-actions.yml",
    ]
    missing = [p for p in required if not (ROOT / p).exists()]
    assert missing == []

def test_solution_mentions_core_requirements():
    combined = "\n".join(read(p) for p in ["README.md", "modules/compute/main.tf", "modules/load_balancer/main.tf"])
    for phrase in ["Auto Scaling Group", "Application Load Balancer", "self-healing", "N+1", "Terraform"]:
        assert phrase.lower() in combined.lower()

def test_no_nat_gateway_to_keep_cost_low():
    tf_text = "\n".join(p.read_text(encoding="utf-8") for p in ROOT.rglob("*.tf"))
    assert "aws_nat_gateway" not in tf_text

def test_asg_min_capacity_two():
    compute = read("modules/compute/main.tf")
    assert "min_size" in compute
    variables = read("variables.tf")
    assert "asg_min_size" in variables
    assert "default     = 2" in variables
