protocol FavouritesConfiguratorProtocol: AnyObject{
    func configure(vc: FavouritesViewProtocol)
}
class FavouritesConfigurator: FavouritesConfiguratorProtocol{
    func configure(vc: FavouritesViewProtocol){
        let interactor = FavouritesInteractor()
        let presenter = FavouritesPresenter()
        let router = FavouritesRouter()
        
        interactor.presenter = presenter
        
        vc.presenter = presenter
        
        router.view = vc
        
        presenter.interactor = interactor
        presenter.view = vc
        presenter.router = router
    }
}
