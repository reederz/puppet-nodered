# Puppet-Node-RED

## Overview

Puppet module for installing [Node-RED](http://nodered.org/).


## Simple Usage

```puppet
include nodered
```

## With Authentication

```puppet
class { 'nodered':
    user => 'user',
    password => 'password',
}
```
