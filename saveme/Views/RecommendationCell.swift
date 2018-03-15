import UIKit

class RecommendationCell: UITableViewCell {
    
    @IBOutlet var sponsorImageView: UIImageView!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var tickImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    var isEditable = false
    var program: Program? {
        didSet {
            setup()
        }
    }
    
    func setup() {
        self.backgroundColor = UIColor(hexString: program?.background ?? "")
        self.nameLabel.text = program?.name
        if program?.sponsor == nil {
            sponsorImageView?.alpha = 0.0
        } else {
            sponsorImageView?.alpha = 1.0
        }
        self.iconImageView.sd_setImage(with: URL(string: self.program?.image ?? ""))
        tickImageView.alpha = 1.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        if isEditable == true {
            if selected == true {
                tickImageView.alpha = 1.0
            } else {
                tickImageView.alpha = 0.0
            }
        }
        
    }
    
    
    
}
