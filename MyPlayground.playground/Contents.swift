//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
private class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

private class Solution_TreeNode {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }
        var result = [[TreeNode]]()
        var level = [TreeNode]()
        
        level.append(root)
        while level.count != 0 {
            result.append(level)
            var nextLevel = [TreeNode]()
            for node in level {
                if let leftNode = node.left {
                    nextLevel.append(leftNode)
                }
                if let rightNode = node.right {
                    nextLevel.append(rightNode)
                }
            }
            level = nextLevel
        }
        
        let ans = result.map { $0.map { $0.val }}
        return ans
    }
}

private class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

private class Solution_ListNode {
    
    private func getNodeValue(_ node: ListNode?) -> Int {
        return node?.val ?? 0//node.flatMap { $0.val } ?? 0
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?)
        -> ListNode? {
            if l1 == nil || l2 == nil {
                return l1 ?? l2
            }
            var p1 = l1
            var p2 = l2
            let result: ListNode? = ListNode(0)
            var current = result
            var extra = 0
            while p1 != nil || p2 != nil || extra != 0 {
                var tot = getNodeValue(p1) +
                    getNodeValue(p2) + extra
                extra = tot / 10
                tot = tot % 10
                let sum:ListNode? = ListNode(tot)
                current!.next = sum
                current = sum
                p1 = p1.flatMap { $0.next }
                p2 = p2.flatMap { $0.next }
            }
            return result!.next
    }
}

private class Solution {
    private var flag: [[Int]]
    private var answer: Int
    private var movex : [Int] {
        return [-1, 1, 0, 0]
    }
    private var movey : [Int] {
        return [0, 0, -1, 1]
    }
    init() {
        flag = [[Int]]()
        answer = 0
    }
    func dfs(_ grid: [[Character]] ,_ x: Int,_ y: Int) {
        for i in 0..<4 {
            let tox = x + movex[i]
            let toy = y + movey[i]
            if tox >= 0 && tox < grid.count && toy >= 0 && toy < grid[0].count && grid[tox][toy] == "1" && flag[tox][toy] == 0 {
                flag[tox][toy] = 1
                dfs(grid, tox, toy)
            }
        }
    }
    func numIslands(_ grid: [[Character]]) -> Int {
        answer = 0
        flag = grid.map { $0.map { _ in return 0 }}
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                if grid[i][j] == "1" && flag[i][j] == 0 {
                    flag[i][j] = 1
                    // print("find in \(i), \(j)")
                    dfs(grid, i, j)
                    answer += 1
                }
            }
        }
        return answer
    }
}


/**
 class Solution {
 public:
 void fillLands(vector<vector<char>>& grid, int px, int py) {
 int movex[] = {0, 0, 1, -1};
 int movey[] = {-1, 1, 0, 0};
 queue<pair<int, int>> q;
 q.push(make_pair(px, py));
 grid[px][py] = '2';
 while (!q.empty()) {
 pair<int, int> item = q.front();
 q.pop();
 int tox, toy;
 for (int i = 0; i < 4; ++i) {
 tox = item.first + movex[i];
 toy = item.second + movey[i];
 if (tox >= 0 && tox < grid.size()
 && toy >=0 && toy < grid[0].size()
 && grid[tox][toy] == '1') {
 grid[tox][toy] = '2';
 q.push(make_pair(tox, toy));
 }
 }
 }
 }
 int numIslands(vector<vector<char>>& grid) {
 int ans = 0;
 for (int i = 0; i < grid.size(); ++i) {
 for (int j = 0; j < grid[0].size(); ++j) {
 if (grid[i][j] == '1') {
 fillLands(grid, i, j);
 ans++;
 }
 }
 }
 return ans;
 }
 };
 */