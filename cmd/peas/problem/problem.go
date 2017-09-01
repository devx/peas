package problem

import (
	"fmt"

	cli "github.com/jawher/mow.cli"
)

// Create a new
func Create(cmd *cli.Cmd) {
	cmd.Action = func() {
		fmt.Println("Create Stub")
	}
}

// List a new
func List(cmd *cli.Cmd) {
	cmd.Action = func() {
		fmt.Println("List Stub")
	}
}

// Delete a new
func Delete(cmd *cli.Cmd) {
	cmd.Action = func() {
		fmt.Println("Delete Stub")
	}
}
