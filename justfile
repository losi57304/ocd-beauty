alias dec := decrypt
alias enc := encrypt

decrypt:
    #!/bin/bash
    set -euo pipefail

    for stack in "stacks"/*; do
        if [[ -f "$stack/.enc.env" ]]; then
            sops decrypt "$stack/.enc.env" > "$stack/.env"
        fi
    done

encrypt:
    #!/bin/bash
    set -euo pipefail

    for stack in "stacks"/*; do
        if [[ -f "$stack/.env" ]]; then
            sops encrypt "$stack/.env" > "$stack/.enc.env"
        fi
    done
