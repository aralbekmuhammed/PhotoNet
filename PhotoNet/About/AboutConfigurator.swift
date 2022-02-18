protocol AboutConfiguratorProtocol: AnyObject{
    func configure(vc: AboutViewProtocol)
}
class AboutConfigurator: AboutConfiguratorProtocol{
    func configure(vc: AboutViewProtocol){
        let interactor = AboutInteractor()
        let presenter = AboutPresenter()
        let router = AboutRouter()
        
        interactor.presenter = presenter
        
        vc.presenter = presenter
        
        router.view = vc
        
        presenter.interactor = interactor
        presenter.view = vc
        presenter.router = router
    }
}
