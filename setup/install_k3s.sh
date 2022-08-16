#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2022-08-16 10:15:52 +0100 (Tue, 16 Aug 2022)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090
. "$srcdir/lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Installs K3s mini kubernetes distribution and adds it to the kubectl config
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args=""

timestamp "Installing K3s"
curl -sfL https://get.k3s.io | sh -

kubeconfig="${KUBECONFIG:-~/.kube/config}"

timestamp "Copying /etc/rancher/k3s/k3s.yaml to $kubeconfig"
mkdir -p ~/.kube

cat /etc/rancher/k3s/k3s.yaml >> "$kubeconfig"
