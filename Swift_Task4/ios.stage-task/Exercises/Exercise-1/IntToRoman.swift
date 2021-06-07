import Foundation

public extension Int {
    
    var roman: String? {
        let unit = "I"
        let five = "V"
        let ten = "X"
        let fifty = "L"
        let hundred = "C"
        let fiveHundred = "D"
        let thousand = "M"
        if self < 1 || self > 3999 {
            return nil
        } else {
            var stringOfUnits : String
            var stringOfTenners : String
            var stringOfHundreds : String
            var StringOfThousands : String
            switch self % 10 {
            case 1:
                stringOfUnits = unit
            case 2:
                stringOfUnits = unit + unit
            case 3:
                stringOfUnits = unit + unit + unit
            case 4:
                stringOfUnits = unit + five
            case 5:
                stringOfUnits = five
            case 6:
                stringOfUnits = five + unit
            case 7:
                stringOfUnits = five + unit + unit
            case 8:
                stringOfUnits = five + unit + unit + unit
            case 9:
                stringOfUnits = unit + ten
            default:
                stringOfUnits = ""
            }
            
            switch self % 100 {
            case 10...19:
                stringOfTenners = ten + stringOfUnits
            case 20...29:
                stringOfTenners = ten + ten + stringOfUnits
            case 30...39:
                stringOfTenners = ten + ten + ten + stringOfUnits
            case 40...49:
                stringOfTenners = ten + fifty + stringOfUnits
            case 50...59:
                stringOfTenners = fifty + stringOfUnits
            case 60...69:
                stringOfTenners = fifty + ten + stringOfUnits
            case 70...79:
                stringOfTenners = fifty + ten + ten + stringOfUnits
            case 80...89:
                stringOfTenners = fifty + ten + ten + ten + stringOfUnits
            case 90...99:
                stringOfTenners = ten + hundred + stringOfUnits
            default:
                stringOfTenners = stringOfUnits
            }
            
            switch self % 1000 {
            case 100...199:
                stringOfHundreds = hundred + stringOfTenners
            case 200...299:
                stringOfHundreds = hundred + hundred + stringOfTenners
            case 300...399:
                stringOfHundreds = hundred + hundred + hundred + stringOfTenners
            case 400...499:
                stringOfHundreds = hundred + fiveHundred + stringOfTenners
            case 500...599:
                stringOfHundreds = fiveHundred + stringOfTenners
            case 600...699:
                stringOfHundreds = fiveHundred + hundred + stringOfTenners
            case 700...799:
                stringOfHundreds = fiveHundred + hundred + hundred + stringOfTenners
            case 800...899:
                stringOfHundreds = fiveHundred + hundred + hundred + hundred + stringOfTenners
            case 900...999:
                stringOfHundreds = hundred + thousand + stringOfTenners
            default:
                stringOfHundreds = stringOfTenners
            }
            
            switch self % 4000 {
            case 1000...1999:
                StringOfThousands = thousand + stringOfHundreds
            case 2000...2999:
                StringOfThousands = thousand + thousand + stringOfHundreds
            case 3000...3999:
                StringOfThousands = thousand + thousand + thousand + stringOfHundreds
            default:
                StringOfThousands = stringOfHundreds
            }
           
          return StringOfThousands
        }
    }
}
