# @summary
#   Manages system-level administration tasks for Redis, primarily sysctl settings.
class redis::administration {
  # Ensure vm.overcommit_memory is set to 1
  # This is generally recommended for Redis to prevent issues with background saves (BGSAVE)
  # or other fork-based operations that might fail due to memory allocation strategies.
  # 0: Kernel performs heuristic memory overcommit handling.
  # 1: Kernel performs no memory overcommit handling.
  # 2: Kernel refuses memory allocations that would exceed the configured overcommit limit.
  sysctl { 'vm.overcommit_memory':
    ensure => 'present',
    value  => '1',
  }

  # Increase the maximum number of connections queued for acceptance.
  # This is beneficial for high-traffic Redis instances to avoid dropping connections
  # when the system is under heavy load. The default is often too low for production Redis.
  sysctl { 'net.core.somaxconn':
    ensure => 'present',
    value  => '65535', # Or another appropriately high value for your environment
  }
}
