#!/usr/bin/env python3

"""
pgsql-create.py

Quick and dirty output some commands to create a role & database.

Copyright 2021  John Begenisich

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
"""

import sys
from pathlib import Path
import argparse
import subprocess


def main():
    parser = argparse.ArgumentParser(description='Quick and dirty output some commands to create a role & database.',
            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('db',
            help='Database/user name')
    args = parser.parse_args()

    result = subprocess.run(['pwgen', '-B', '30', '1'], stdout=subprocess.PIPE)
    password = result.stdout.decode().strip()

    print(f"CREATE ROLE {args.db} WITH LOGIN PASSWORD '{password}';")
    print(f'CREATE DATABASE {args.db};')
    print(f'REVOKE CONNECT ON DATABASE {args.db} FROM PUBLIC;')
    print(f'GRANT CONNECT ON DATABASE {args.db} TO {args.db};')
    print(f'GRANT ALL PRIVILEGES ON DATABASE {args.db} TO {args.db};')


# -------------------------------------------------


if __name__ == '__main__':
    main()

