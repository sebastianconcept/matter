Smalltalk vm maxExternalSemaphoresSilently: 1024 * 16.

Deprecation showWarning: false.

Metacello new
  baseline: 'Matter';
  repository: 'github://sebastianconcept/matter/src';
  load.

Smalltalk snapshot: true andQuit: true.