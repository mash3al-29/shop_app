
abstract class ShopStates{}

class InitialShopState extends ShopStates{}

class ChangeNavBarShopApp extends ShopStates{}

class GetProductsShopSucsess extends ShopStates{}

class GetProductsShopError extends ShopStates{
  final String error;

  GetProductsShopError(this.error);
}

class GetProductsShopLoading extends ShopStates{}

class GetCategoriesShopSucsess extends ShopStates{}

class GetCategoriesShopError extends ShopStates{
  final String error;

  GetCategoriesShopError(this.error);
}

class GetCategoriesShopLoading extends ShopStates{}

class ChangeFavouritesShopSucsess extends ShopStates{}

class ChangeFavouritesShopError extends ShopStates{
  final dynamic error;

  ChangeFavouritesShopError(this.error);
}

class ChangeFavouritesShopLoading extends ShopStates{}

class ChangeFavouritesStatusFalseShop extends ShopStates{}

class GetFavouritesShopSucsess extends ShopStates{}

class GetFavouritesShopError extends ShopStates{
  final dynamic error;

  GetFavouritesShopError(this.error);
}

class GetFavouritesShopLoading extends ShopStates{}

class GetProfileLoading extends ShopStates{}

class GetProfileSucses extends ShopStates{}

class GetProfileError extends ShopStates{}



