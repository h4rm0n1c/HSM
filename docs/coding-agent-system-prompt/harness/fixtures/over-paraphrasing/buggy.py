import subprocess


def deploy(environment):
    cmd = [
        "deploy-tool",
        "--target", environment,
        "--version", "v2.1.0",
    ]
    return subprocess.run(cmd, check=True)
