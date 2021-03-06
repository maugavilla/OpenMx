#
#   Copyright 2007-2019 by the individuals mentioned in the source code history
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
# 
#        http://www.apache.org/licenses/LICENSE-2.0
# 
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.


require(OpenMx)
library(testthat)

A <- mxMatrix('Full', 1, 1, labels = 'data.foo', name = 'A')
B <- mxAlgebra(data.foo + A, name = 'B')
data <- mxData(matrix(c(1:5), 5, 1, dimnames = list(NULL, c('foo'))), type='raw')
model <- mxModel('model', A, B, data)

omxCheckEquals(mxEval(A[1,1], model, compute=FALSE), 0)
expect_error(mxEval(A[1,1], model, compute=TRUE, defvar.row = 0),
	"Row number '0' is out of bounds for definition variable")
omxCheckEquals(mxEval(A[1,1], model, compute=TRUE), 1)
omxCheckEquals(mxEval(A[1,1], model, compute=TRUE, defvar.row=2), 2)
omxCheckEquals(mxEval(A[1,1], model, compute=TRUE, defvar.row=3), 3)
omxCheckEquals(mxEval(A[1,1], model, compute=TRUE, defvar.row=4), 4)
omxCheckEquals(mxEval(A[1,1], model, compute=TRUE, defvar.row=5), 5)
expect_error(mxEval(A[1,1], model, compute=TRUE, defvar.row = 6),
	paste("Row number '6' is out of",
	"bounds for definition variable"))

omxCheckEquals(mxEval(B[1,1], model, compute=TRUE), 2)
omxCheckEquals(mxEval(B[1,1], model, compute=TRUE, defvar.row=2), 4)
omxCheckEquals(mxEval(B[1,1], model, compute=TRUE, defvar.row=3), 6)
omxCheckEquals(mxEval(B[1,1], model, compute=TRUE, defvar.row=4), 8)
omxCheckEquals(mxEval(B[1,1], model, compute=TRUE, defvar.row=5), 10)
expect_error(mxEval(B[1,1], model, compute=TRUE, defvar.row = 0),
	paste("Row number '0' is out of",
	"bounds for definition variable"))
expect_error(mxEval(B[1,1], model, compute=TRUE, defvar.row = 6),
	paste("Row number '6' is out of",
	"bounds for definition variable"))
