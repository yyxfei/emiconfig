#!/usr/bin/env python

import os, re, shutil, time

root_dir = '/scratch'
site = 'cce.ihep.ac.cn'
log_files = ['cmsRun-stdout.log']
log_max_size = 15  # in GB
log_min_idle = 10  # in minute

def get_all_job_dirs(root_dir):
  job_dirs = []
  for dir in os.listdir(root_dir):
    job_dir = os.path.join(root_dir,dir)
    if os.path.isdir(job_dir) and re.match('\d*\.%s$'%(site.replace('.','\\.')), dir):
      job_dirs.append(job_dir)
  return job_dirs

def get_all_subdirs(job_dir):
  subdirs = []
  for glide_dir in os.listdir(job_dir):
    if os.path.isdir(os.path.join(job_dir,glide_dir)) and re.match('glide_.*', glide_dir):
      exe_dir = os.path.join(job_dir,glide_dir,'execute')
      for dir in os.listdir(exe_dir):
        subdir = os.path.join(exe_dir,dir)
        if os.path.isdir(subdir) and re.match('dir_\d*$', dir):
          subdirs.append(subdir)
      break
  return subdirs

def remove_old_dirs(subdirs):
  latest_time = 0
  latest_dir = ''
  for subdir in subdirs:
    mtime = os.path.getmtime(subdir)
    if mtime > latest_time:
      latest_time = mtime
      latest_dir = subdir

  for subdir in subdirs:
    if subdir != latest_dir:
      print 'Directory %s will be removed' % subdir
      shutil.rmtree(subdir)
      shutil.rmtree(subdir+'.condor')

  return latest_dir

def check_large_log(log_file_path):
  log_size = os.path.getsize(log_file_path)/1024./1024./1024.
  log_idle = (time.time() - os.path.getmtime(log_file_path)) / 60.
  if log_size < log_max_size:
    return
#  if log_idle > log_min_idle:
#    return

  print "Remove too large log file %s. Size %s GB. Idle time %s minute" % (log_file_path, log_size, log_idle)
#  os.remove(log_file_path)
  shutil.rmtree(os.path.dirname(log_file_path))
  shutil.rmtree(os.path.dirname(log_file_path)+'.condor')

def find_large_log(main_dir):
  for root, dirs, files in os.walk(main_dir):
    for log_file in log_files:
      if log_file in files:
        log_file_path = os.path.join(root, log_file)
        check_large_log(log_file_path)


def main():
  job_dirs = get_all_job_dirs(root_dir)
  print 'All job directories:'
  for job_dir in job_dirs:
    print job_dir
  print ''

  for job_dir in job_dirs:
    subdirs = get_all_subdirs(job_dir)

    main_dir = ''
    if len(subdirs) > 1:
      main_dir = remove_old_dirs(subdirs)
    elif len(subdirs) == 1:
      main_dir = subdirs[0]

    if main_dir:
      find_large_log(main_dir)


if __name__ == '__main__':
  main()
