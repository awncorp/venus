{
  'name' => 'Test',
  '$metadata' => {
    'varlog' => '/var/log',
    'tmplog' => '/tmp/log',
  },
  '$services' => {
    'log' => {
      'package' => 'Venus/Path',
      'argument' => {
        '$metadata' => 'tmplog'
      }
    },
    'development_log' => {
      'package' => 'Venus/Path',
      'extends' => 'log',
      'builder' => [
        {
          'method' => 'new',
          'return' => 'self',
          'inject' => 'list'
        },
        {
          'method' => 'child',
          'argument' => 'development.log',
          'return' => 'result'
        },
      ]
    },
    'production_log' => {
      'package' => 'Venus/Path',
      'extends' => 'log',
      'argument' => {
        '$metadata' => 'varlog'
      },
      'builder' => [
        {
          'method' => 'new',
          'return' => 'self',
          'inject' => 'hash'
        },
        {
          'method' => 'child',
          'argument' => 'production.log',
          'return' => 'result'
        },
      ]
    },
    'staging_log' => {
      'package' => 'Venus/Path',
      'extends' => 'log',
      'builder' => [
        {
          'method' => 'new',
          'return' => 'self',
          'inject' => 'hash'
        },
        {
          'method' => 'child',
          'argument' => 'staging.log',
          'return' => 'result'
        },
      ]
    },
    'testing_log' => {
      'package' => 'Venus::Path',
      'builder' => [
        {
          'method' => 'new',
          'argument' => {
            '$service' => 'filetemp',
          },
          'return' => 'self',
        },
        {
          'method' => 'child',
          'argument' => 'testing.log',
          'return' => 'result'
        },
      ]
    },
    'filetemp' => {
      'package' => 'File/Temp',
      'constructor' => 'newdir',
    },
  }
}
