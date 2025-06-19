local helpers = require('snippets-helper')
local get_visual = helpers.get_visual
local clipboard_content = helpers.clipboard_content
local line_begin = require('luasnip.extras.expand_conditions').line_begin

return {
  -- async error logging
  s(
    { trig = 'main', snippetType = 'autosnippet' },
    fmta(
      [[
      import asyncio
      import logging
      from functools import wraps

      malogger = logging.getLogger("malogger")

      def exception_logger(_func=None, logger=logging.getLogger()):
        def decorator(func):
        @wraps(func)
        def sync_wrapper(*args, **kwargs):
          try:
            return func(*args, **kwargs)
          except Exception as e:
            logger.exception(f"An error occurred running {func.__name__}: {e}")
            raise

        async def async_wrapper(*args, **kwargs):
          try:
            return await func(*args, **kwargs)
          except Exception as e:
            logger.exception(f"An error occurred running {func.__name__}: {e}")
            raise

        if asyncio.iscoroutinefunction(func):
          return async_wrapper
        else:
          return sync_wrapper

      if _func is None:
        return decorator
      else:
        return decorator(_func)
      
      @exception_logger(logger=malogger)
      def <>
      ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
}
