import Foundation

final class FillWithColor {
    
    var mutableImage: [[Int]] = [[]]
    private func recursivePainting(_ mutableImage: inout [[Int]], _ row: Int, _ column: Int, _ oldColor: Int, _ newColor: Int) {
        
     
        if row >= mutableImage.count ||  column >= mutableImage[0].count || row < 0 || column < 0 || mutableImage[row][column] != oldColor || mutableImage[row][column] == newColor {return} else {
        
        mutableImage[row][column] = newColor
        recursivePainting(&mutableImage, row, column + 1, oldColor, newColor)
        recursivePainting(&mutableImage, row - 1, column, oldColor, newColor)
        recursivePainting(&mutableImage, row, column - 1, oldColor, newColor)
        recursivePainting(&mutableImage, row + 1, column, oldColor, newColor)
        
        return
        }
    }

    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        guard (!image.isEmpty || image.first!.isEmpty || row > image.count || column > image[0].count || column > 50 || row > 50 ||  row < 0 || column < 0 || newColor > 65536 ) else {
            return image
        }
        let oldColor = image[row][column]
        mutableImage = image
        recursivePainting(&mutableImage, row, column, oldColor, newColor)
        return mutableImage
    }
}
