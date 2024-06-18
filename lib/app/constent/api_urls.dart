class ConstantsUrls {
  ConstantsUrls._();

  static const String baseURL = 'https://petfinder.booksica.in';

  static const String loginUrls = '/api/users/login';
  static const String signUpUrl = '/api/users/signup';
  static const String otpUrl = '/api/verifyotp/';
  static const String getAllUsersUrl = '/api/users';
  static const String createOwnerUrl = '/api/createOwner/';
  static const String createPetUrl = '/api/createPet';
  static const String updatePetUrl = '/api/updatePet/';
  static const String updateUser = '/api/updateUser/';
  static const String getUser = '/api/getUser/';
  static const String getAllPetByUser = '/api/getAllPetByUser/';
  static const String getPetById = '/api/getPetById/';
  static const String writeNote = '/api/writeNote/';
  static const String addPet = '/api/addPet';
  static const String petMissing = '/api/missingPetActive/';
  static const String addCoowner = '/api/createCoowner/';
  static const String updateCoowner = '/api/updateCoowner/';
  static const String getCoowner = '/api/getCoOwnerById/';

  static const String getNotifications = '/api/getNotification/';
  static const String getpetbyRfid = '/api/getOwnerByPet/';

  static const String writeLastSeenNote = '/api/writeLastSeen/';
  static const String updateVaccine = '/pet/updateVaccine';
  static const String GetAllBreed = '/api/getBreed';
  static const String GetAllVaccine = '/api/getAllVaccine';
  static const String GetAllPetByVolunteer = '/api/getPetByUser/careTaker/';
  static const String GetAllPetByGuardian = '/api/getPetByUser/guardian/';

  // ignore: constant_identifier_names
  // static const String THUMB = '${baseURL}thumb.png';
  // static const String PET_FOOT = '${baseURL}pet_foot.png';
  // static const String PEOPLE = '${baseURL}people.png';
  // static const String ICON = '${baseURL}icon.png';
  // static const String BIRTHDAY = '${baseURL}Birthday.png';
  // static const String CALENDER = '${baseURL}calender.png';
  // static const String CAMERA = '${baseURL}camera.png';
  // static const String ERROR = '${baseURL}Error.png';
  // static const String LOGO = '${baseURL}logo.png';
  // static const String INJECTION = '${baseURL}injection.png';
  // ignore: constant_identifier_names
  static const String APPNAME = 'Pet Aadhaar';
}
