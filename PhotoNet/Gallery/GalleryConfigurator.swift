protocol GalleryConfiguratorProtocol: AnyObject{
    func configure(vc: GalleryViewProtocol)
}
class GalleryConfigurator: GalleryConfiguratorProtocol{
    func configure(vc: GalleryViewProtocol){
        let interactor = GalleryInteractor()
        let presenter = GalleryPresenter()
        let router = GalleryRouter()
        
        interactor.presenter = presenter
        
        vc.presenter = presenter
        
        router.view = vc
        
        presenter.interactor = interactor
        presenter.view = vc
        presenter.router = router
    }
}
