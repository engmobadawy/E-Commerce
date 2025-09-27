import UIKit

final class HomeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var firstCollection: UICollectionView!
    @IBOutlet weak var firstContainer: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pinContainer: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchFieldBackGround: UIView!
    @IBOutlet weak var secondCollection: UICollectionView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionViewHeight: NSLayoutConstraint!

    // MARK: - Properties
    private var timer: Timer?
    private var dataSource = DataSource()
    private var currentIndex = 0
    private var selectedCategoryIndex: Int = 0 {
        didSet { reloadProductsForSelectedCategory() }
    }
    private var filteredProducts: [Product] = []
    private var isPinned = false
    
    // MARK: - Constants
    private enum Layout {
        static let pinnedHeight: CGFloat = 143
        static let categoryItemSize = CGSize(width: 63, height: 65)
        static let itemSpacing: CGFloat = 23
        static let productSpacing: CGFloat = 3
        static let pinHorizontalMargin: CGFloat = 23
        static let timerInterval: TimeInterval = 3
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollections()
        setupTimer()
        loadInitialData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateSecondCollectionHeight()
        adjustPinContainerFrameIfPinned()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Home"
        pageControl.numberOfPages = dataSource.arrOffers.count
    }
    
    private func setupCollections() {
        let collections = [
            (firstCollection, Constants.identifier.firstCollectionViewCell),
            (secondCollection, Constants.identifier.SecondCollectionViewCell),
            (sliderCollectionView, Constants.identifier.ScrollingCollectionViewCell)
        ]
        
        collections.forEach { collection, identifier in
            collection?.register(UINib(nibName: identifier, bundle: nil),
                               forCellWithReuseIdentifier: identifier)
            collection?.delegate = self
            collection?.dataSource = self
        }
        
        firstCollection.showsHorizontalScrollIndicator = false
        firstCollection.backgroundColor = .systemBackground
        secondCollection.showsVerticalScrollIndicator = false
        sliderCollectionView.layer.cornerRadius = 10
        
        mainScrollView.delegate = self
        searchBar.delegate = self
    }
    
    private func setupTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: Layout.timerInterval,
                                   target: self,
                                   selector: #selector(moveToNextIndex),
                                   userInfo: nil,
                                   repeats: true)
    }
    
    private func loadInitialData() {
        dataSource.loadData { [weak self] _ in
            self?.selectInitialCategory()
        }
    }

    private func selectInitialCategory() {
        guard !dataSource.arrTopCategories.isEmpty else { return }
        selectedCategoryIndex = 0
        let firstIndexPath = IndexPath(item: 0, section: 0)
        firstCollection.selectItem(at: firstIndexPath, animated: false, scrollPosition: .left)
        reloadProductsForSelectedCategory()
    }

    private func updateSecondCollectionHeight() {
        secondCollection.collectionViewLayout.invalidateLayout()
        secondCollectionViewHeight?.constant = secondCollection.collectionViewLayout.collectionViewContentSize.height
    }

    private func adjustPinContainerFrameIfPinned() {
        guard isPinned else { return }
        pinContainer.frame = CGRect(
            x: Layout.pinHorizontalMargin,
            y: view.safeAreaInsets.top,
            width: view.bounds.width - (Layout.pinHorizontalMargin + 9),
            height: Layout.pinnedHeight
        )
    }

    @objc private func moveToNextIndex() {
        currentIndex = (currentIndex + 1) % dataSource.arrOffers.count
        sliderCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0),
                                        at: .centeredHorizontally,
                                        animated: true)
        pageControl.currentPage = currentIndex
    }

    private func reloadProductsForSelectedCategory() {
        guard selectedCategoryIndex < dataSource.arrTopCategories.count else { return }
        filteredProducts = dataSource.arrTopCategories[selectedCategoryIndex].products
        secondCollection.reloadData()
        secondCollection.layoutIfNeeded()
        updateSecondCollectionHeight()
    }
    
    // MARK: - Pinning Logic
    private func pinCategories() {
        let currentFrame = pinContainer.convert(pinContainer.bounds, to: view)
        let height = currentFrame.height > 0 ? currentFrame.height : Layout.pinnedHeight
        
        pinContainer.removeFromSuperview()
        pinContainer.translatesAutoresizingMaskIntoConstraints = true
        pinContainer.frame = CGRect(
            x: Layout.pinHorizontalMargin,
            y: view.safeAreaInsets.top,
            width: view.bounds.width - 35,
            height: height
        )
        
        view.addSubview(pinContainer)
        
        if mainScrollView.contentInset.top < height - 0.5 {
            mainScrollView.contentInset.top += height
            mainScrollView.verticalScrollIndicatorInsets.top += height
        }
        
        isPinned = true
    }

    private func unpinCategories() {
        pinContainer.removeFromSuperview()
        pinContainer.translatesAutoresizingMaskIntoConstraints = false
        firstContainer.addSubview(pinContainer)
        
        NSLayoutConstraint.activate([
            pinContainer.topAnchor.constraint(equalTo: firstContainer.topAnchor),
            pinContainer.leadingAnchor.constraint(equalTo: firstContainer.leadingAnchor),
            pinContainer.trailingAnchor.constraint(equalTo: firstContainer.trailingAnchor),
            pinContainer.bottomAnchor.constraint(equalTo: firstContainer.bottomAnchor)
        ])
        
        mainScrollView.contentInset.top = 0
        mainScrollView.verticalScrollIndicatorInsets.top = 0
        isPinned = false
    }
}

// MARK: - UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case firstCollection: return dataSource.arrTopCategories.count
        case secondCollection: return filteredProducts.count
        case sliderCollectionView: return dataSource.arrOffers.count
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case firstCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.identifier.firstCollectionViewCell, for: indexPath) as! firstCollectionViewCell
            cell.icon.image = dataSource.arrTopCategories[indexPath.item].icon
            return cell
            
        case secondCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.identifier.SecondCollectionViewCell, for: indexPath) as! SecondCollectionViewCell
            let product = filteredProducts[indexPath.item]
            cell.outImage.image = product.image
            cell.Label.text = product.name
            return cell
            
        case sliderCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.identifier.ScrollingCollectionViewCell, for: indexPath) as! ScrollingCollectionViewCell
            cell.image3.image = dataSource.arrOffers[indexPath.item]
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == firstCollection {
            selectedCategoryIndex = indexPath.item
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case firstCollection:
            return Layout.categoryItemSize
        case secondCollection:
            let width = (collectionView.frame.width - 15) / 2
            return CGSize(width: width, height: 204)
        case sliderCollectionView:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        default:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.itemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == firstCollection ? Layout.itemSpacing : Layout.productSpacing
    }
}

// MARK: - UIScrollViewDelegate
extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == mainScrollView else { return }
        
        let sliderBottomInView = sliderCollectionView.convert(sliderCollectionView.bounds, to: view).maxY
        let shouldPin = sliderBottomInView <= view.safeAreaInsets.top + 1
        
        if shouldPin && !isPinned {
            pinCategories()
        } else if !shouldPin && isPinned {
            unpinCategories()
        }
    }
}

// MARK: - UISearchBarDelegate
extension HomeVC: UISearchBarDelegate {
    // Add search functionality as needed
}
