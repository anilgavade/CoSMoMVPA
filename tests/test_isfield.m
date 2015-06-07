function test_suite=test_isfield
    initTestSuite;

function test_isfield_basics
    a=struct();
    a.foo=1;
    a.bar.baz=2;

    assertTrue(cosmo_isfield(a,'foo'));
    assertTrue(cosmo_isfield(a,'bar.baz'));
    assertFalse(cosmo_isfield(a,'baz'));
    assertEqual(cosmo_isfield(a,{'bar','baz','foo','bar','bar.baz'}),...
                                    [true false true true true]);

    a2=cat(1,a,a);
    assertTrue(cosmo_isfield(a2,'foo'));
    assertTrue(cosmo_isfield(a2,'bar'));
    assertFalse(cosmo_isfield(a2,'baz'));
    assertEqual(cosmo_isfield(a2,{'bar','baz','foo','bar'}),...
                                    [true false true true]);
    a_a2=a;
    a_a2.bar=a2;
    assertTrue(cosmo_isfield(a_a2,'bar.bar'));
    assertTrue(cosmo_isfield(a_a2,'bar.foo'));
    assertFalse(cosmo_isfield(a_a2,'bar.baz'));

    assertExceptionThrown(@()cosmo_isfield(a2,'baz',true),'');
    assertExceptionThrown(@()cosmo_isfield(a2,'bar.baz',true),'');
    assertExceptionThrown(@()cosmo_isfield(a2,'bar.bar.baz',true),'');