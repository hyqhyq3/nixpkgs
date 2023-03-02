{ lib
, fetchPypi
, buildPythonPackage
, urllib3
, geojson
, isPy3k
, sqlalchemy
, pytestCheckHook
, pytz
, stdenv
}:

buildPythonPackage rec {
  pname = "crate";
  version = "0.30.0";
  disabled = !isPy3k;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-8xraDCFZbpJZsh3sO5VlSHwnEfH4u4AJZkXA+L4TB60=";
  };

  propagatedBuildInputs = [
    urllib3
    sqlalchemy
    geojson
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pytz
  ];

  disabledTests = [
    # the following tests require network access
    "test_layer_from_uri"
    "test_additional_settings"
    "test_basic"
    "test_cluster"
    "test_default_settings"
    "test_dynamic_http_port"
    "test_environment_variables"
    "test_verbosity"
  ];

  disabledTestPaths = [
    # imports setuptools.ssl_support, which doesn't exist anymore
    "src/crate/client/test_http.py"
  ];

  meta = with lib; {
    homepage = "https://github.com/crate/crate-python";
    description = "A Python client library for CrateDB";
    license = licenses.asl20;
    maintainers = with maintainers; [ doronbehar ];
  };
}
