#!/usr/bin/env python3
'''
--------------------------------------------------------------------------------------------------------------
- Runs each of the frameworks using a ClI
- All builds are done locally
- View more -> docs/cli.md
--------------------------------------------------------------------------------------------------------------
'''

import click
import sys

sys.path.insert(1, 'tools/')

from list_information import *
from run_framework import *

# ----------------------------------------------- CLI flags --------------------------------------------------------

@click.command()
@click.option("--runall", is_flag=True, help="runs all framework tests and does a local build of each docker container")
@click.option("--list_frameworks", "-listf", is_flag=True, help="Lists all framework avaliable to test")
@click.option("--run_framework", "-runf", help="(ex: 'ruby/rails6') default runs are in local build mode")
@click.option("--list_images", "-listi", is_flag=True, help="Lists all docker images")
@click.option("--list_contianers", "-listc", is_flag=True, help="Lists all docker list_contianers")

# -------------------------------------------------------------------------------------------------------------------
# -------------------------------------- Actions when flags are called ----------------------------------------------

def main(runall,list_frameworks,run_framework,list_images,list_contianers):

    # Runs all the frameworks
    if runall:
        for i in frameworks_on_disk():
            build_run_framework(i)

    # Runs specific framework
    elif run_framework:
        build_run_framework(run_framework)

    # Lists all frameworks avaliable
    elif list_frameworks:
        frameworks_on_disk()

    # Lists all docker images build
    elif list_images:
        images_on_disk()

    # Lists all continers running
    elif list_contianers:
        containers_on_disk()

    # Display --help information when no flag is called
    else:
        ctx = click.get_current_context()
        click.echo(ctx.get_help())

# -------------------------------------------------------------------------------------------------------------------

if __name__ == "__main__":
    main()
