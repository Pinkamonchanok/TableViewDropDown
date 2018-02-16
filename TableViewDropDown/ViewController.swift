
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var sections = [
        Section(genre: " 🎫 สิ่งสำคัญ",
                movies: ["Passport", "บัตรประชาชน","เงินสด/บัตรเครดิต","ตั๋วรถ/ตั๋วเครื่องบิน","ใบจองที่พัก","ปากกา+สมุดบันทึก","มือถือ + ที่ชาร์จแบต "],
                expanded: false),
        Section(genre: "👔 เสื้อผ้่า",
                movies: ["เสื้อ__ตัว", "กางเกง/กระโปรง__ตัว", "กางเกงใน/ชุดชั้นใน", "เสื้อกันหนาว","ชุดนอน","ชุดว่ายน้ำ/หมวก/แว่นตา","ถุงเท้า","หมวก","ถุงมือ/ผ้าพันคอ","รองเท้าแตะ","รองเท้าผ้าใบ","แว่นกันแดด","ร่ม/เสื้อกันฝน"],
                expanded: false),
        Section(genre: "💊ยารักษาโรค/ยาประจำตัว",
                movies: ["ยาประจำตัว", "ยาแก้ปวด", "ยาแก้แพ้","พลาสเตอร์","ยาทาบรรเทาปวด","ยาหน่อง/ยาดม","ยาธาตุน้ำขาว"],
                expanded: false),
        Section(genre: "📸อุปกรณ์ถ่ายภาพ",
                movies: ["กล้องถ่ายรูป", "กล้องวีดีโอ", "Notebook","Memory Card","ผ้าเช็ดเลนส์ + ที่เป่าฝุ่น","ขาตั้งกล้อง","สายชาร์จ"],
                expanded: false),
        Section(genre: "📌ของใช้เบ็ดเตล็ด",
                movies: ["แปรงสีฟัน + ยาสีฟัน", "สบู่", "แชมพู +ครีมนวด","โฟมล้างหน้า","หวี/ยางรัดผม","มีดโกนหนวด","โคโลญ/แป้ง","น้ำหอม","เครื่องสำอาง/เครื่องประดับ","ครีมบำรุงผิว"],
                expanded: false),
        Section(genre: "🎒 อื่น ๆ",
                movies: ["ถุง zip lock", "ถุงพลาสติก", "แม่กุญแจ + กุญแจ","ทิชชู่","ไฟฉาย","ยากันยุง"],
                expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].movies.count
    }
    //hrowheader
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    //hrowinsection
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 44
        } else {
            return 0
        }
    }
    //space between section
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genre, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = sections[indexPath.section].movies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
    }
 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            sections[indexPath.section].movies.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
     func toggleSection(header: ExpandableHeaderView, section: Int) {
         sections[section].expanded = !sections[section].expanded
         tableView.beginUpdates()
         for i in sections[section].movies.count ..< sections[section].movies.count {
         tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
     }
     tableView.endUpdates()
     }

}

