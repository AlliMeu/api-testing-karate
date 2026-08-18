function fn() {
  // No token is committed here on purpose - get your own free one at
  // gorest.co.in/my-account/access-tokens and export it as GOREST_TOKEN
  // before running the gorest-users tests. Without it, those specific
  // write scenarios will fail with 401, which is expected, not a bug.
  var gorestToken = karate.properties['gorest.token'] || 'REPLACE_WITH_YOUR_OWN_GOREST_TOKEN';
  return {
    gorestToken: gorestToken
  };
}
