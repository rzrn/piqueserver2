# Copyright © 2026 rzrn

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

import inspect
import logging

class FormatLogger(logging.Logger):
    def _log(self, level, msg, w, exc_info = None, extra = None, stack_info = False, stacklevel = 1, **kw):
        super()._log(
            level, str(msg).format(*w, **kw), (),
            exc_info = exc_info, extra = extra, stack_info = stack_info, stacklevel = stacklevel + 1
        )

logging.setLoggerClass(FormatLogger)

def getLogger(name = None):
    if name is None:
        name = inspect.currentframe().f_back.f_globals['__name__']

    return logging.getLogger(name)
