package report

import (
	"fmt"

	cli "github.com/jawher/mow.cli"
)

// View a new
func View(cmd *cli.Cmd) {
	cmd.Action = func() {
		fmt.Println("View Stub")
	}
}
