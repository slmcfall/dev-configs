select
   foo as foo
from {{ ref('foo') }} as foo
where 1=1

