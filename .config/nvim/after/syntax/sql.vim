syn region  dbtJinjaTemplate   start=+{%+ end=+%}+ contains=@dbtJinja,jinjaStatement,jinjaFilter,dbtJinjaTemplate transparent 
syn region  dbtJinjaTemplate   start=+{{+ end=+}}+ contains=@dbtJinja,jinjaStatement,jinjaFilter,dbtJinjaTemplate transparent
syn keyword dbtJinjaKeyword     this containedin=dbtJinjaTemplate
hi  link    dbtJinjaKeyword     PreProc
