var STATIC_PLANE = 4;

String.prototype.swap = function(fromIndex, toIndex) {
    "use strict";
    var strs = this.split("");
    var fromStr = strs[fromIndex];
    var toStr = strs[toIndex];
    strs[fromIndex] = toStr;
    strs[toIndex] = fromStr;
    return strs.join("");
};

var swap = function(str, fromRow, fromCol, toRow, toCol) {
    var fromIndex = fromRow*STATIC_PLANE + fromCol;
    var toIndex = toRow*STATIC_PLANE + toCol;
    return str.swap(fromIndex, toIndex);
};

var startNode = {
    "state": "2011001100110011"
    , "row": 0
    , "col": 0
    , "prev": null
};

var targetState = "2101101001011010";

var nodes = [startNode];
var visited = [startNode["state"]];
var q = 0;
var moves = [];
while (q < nodes.length) {
    var cur = nodes[q];
    q += 1;

    var s = cur["state"], r = cur["row"], c = cur["col"];

    if (s == targetState) {
        var trace = function(node) {
            console.time("trace");
            if (node["prev"] != null) {
                trace(node["prev"]);
            } else {
                return;
            }
            var r1 = node["prev"]["row"];
            var c1 = node["prev"]["col"];
            var r2 = node["row"];
            var c2 = node["col"];
            if (r2 == r1 - 1) {
                moves.push("U");
            } else if (r2 == r1 + 1) {
                moves.push("D");
            } else if (c2 == c1 - 1) {
                moves.push("L");
            } else {
                moves.push("R");
            }
            console.time("trace");
        };

        trace(cur);
        break;
    }

    var move = function(row, col) {
        console.time("move");
        if (row >= 0 && row < STATIC_PLANE
            && col >= 0 && col < STATIC_PLANE) {
            var state = swap(s, r, c, row, col);
            if (visited.indexOf(state) == -1) {
                visited.push(state);
                nodes.push({
                    "state": state
                    , "row": row
                    , "col": col
                    , "prev": cur
                });
            }
        }
        console.timeEnd("move");
    };

    move(r - 1, c);
    move(r + 1, c);
    move(r, c - 1);
    move(r, c + 1);
}

console.log(moves.join("\s"));