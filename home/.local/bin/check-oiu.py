#!/usr/bin/env python3

"""
check-oiu.py

Look up MACs in the IEEE MAC database.

Copyright 2020  John Begenisich

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
    parser = argparse.ArgumentParser(description='Look up MACs in the IEEE MAC database',
            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('mac',
            help='MAC address in 00:00:00:00:00 or 00-00-00-00-00 or 00000000 format')
    parser.add_argument('--oiu', default=Path.home() / '.local' / 'share' / 'oiu.txt',
            help='Path to oiu.txt')
    parser.add_argument('-u', '--update-oiu', action='store_true', default=False,
            help='update oiu.txt')
    args = parser.parse_args()
    mac = args.mac.replace('-', '').replace(':', '').upper()[:6]
    if len(mac) < 6:
        print(f'Mac "{mac}" too short - need at least three octets')
        sys.exit(1)

    oiu_file = Path(args.oiu)
    if not oiu_file.exists() or args.update_oiu:
        print(f'Downloading {oiu_file}...')
        result = subprocess.run(['curl', '--compressed', 'http://standards-oui.ieee.org/oui.txt', '-o', str(oiu_file)])
        if result.returncode != 0:
            sys.exit(1)

    result = subprocess.run(['grep', '-B', '1', '-A', '3', mac, str(oiu_file)])
    if result.returncode != 0:
        sys.exit(1)

# -------------------------------------------------


if __name__ == '__main__':
    main()
