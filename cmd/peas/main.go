package main

import (
	"fmt"
	"os"

	"github.com/devx/peas/cmd/peas/plan"
	"github.com/devx/peas/cmd/peas/problem"
	"github.com/devx/peas/cmd/peas/progress"
	"github.com/devx/peas/cmd/peas/project"
	"github.com/devx/peas/cmd/peas/report"
	"github.com/jawher/mow.cli"
)

// GitVersion that matches a git version
var GitVersion = "No Version Provided"

func main() {

	BuildVersion := fmt.Sprintf("Version: %s\n", GitVersion)

	app := cli.App("peas", "Utility to keep track of your Proggres, Plans, Problems.")

	app.Version("v version", BuildVersion)

	app.Command("new", "create new project", project.New)

	app.Command("progress", "progess actions", func(act *cli.Cmd) {
		act.Command("create", "Create a new progress item for the week", progress.Create)
		act.Command("list", "list this weeks progress items", progress.List)
		act.Command("delete", "delete a progess item for the week", progress.Delete)
	})

	app.Command("plan", "plan actions", func(act *cli.Cmd) {
		act.Command("create", "Create a new plan item for the week", plan.Create)
		act.Command("list", "list this weeks plan items", plan.List)
		act.Command("delete", "delete a planed item for the next week", plan.Delete)
	})

	app.Command("problem", "problem actions", func(act *cli.Cmd) {
		act.Command("create", "Create a new problem item for the week", problem.Create)
		act.Command("list", "list this weeks problem items", problem.List)
		act.Command("delete", "delete a problemed item for the next week", problem.Delete)
	})

	app.Command("report", "report actions", func(act *cli.Cmd) {
		act.Command("view", "View this weeks report", report.View)
	})

	app.Run(os.Args)
}
