package main

import (
	"os"
	"path/filepath"

	"github.com/urfave/cli/v2"
)

var cmdDoctor = &cli.Command{
	Name:  "doctor",
	Usage: "checks that the environment is healty",
	Flags: []cli.Flag{},
	Action: func(c *cli.Context) error {
		// Pre-checks

		// TODO: schema for pre-checks

		// Enter the devshell

		// TODO: library to enter the devshell

		// Execute the post-checks

		// TODO: execute the doctor script

		return nil
	}
}
