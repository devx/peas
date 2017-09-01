package project

import (
	"fmt"

	cli "github.com/jawher/mow.cli"
)

// New a new
func New(cmd *cli.Cmd) {
	cmd.Action = func() {
		fmt.Println("New Stub")
	}
}
