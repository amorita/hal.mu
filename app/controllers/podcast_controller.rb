class PodcastController < ApplicationController
  
  require 'taglib'
  
  def rehearsal
    urlbase = 'http://hal.mu/rehearsal_recs/'
    files = `ls /home/yu/www/priv.hal.mu/rehearsal_recs/*.mp3 -t`.split "\n"
    @list = []
    files.each do |filepath|
      fileinfo = {}
      file = File.stat filepath
      fileinfo[:update] = file.mtime
      if @lastbuilddate.nil?
        @lastbuilddate = file.mtime
      end
      fileinfo[:url] = urlbase + File.basename(filepath)
      fileinfo[:file] = File.basename(filepath)
      fileinfo[:length] = file.size
      TagLib::MPEG::File.open(filepath) do |mp3_file|
        tag = mp3_file.id3v2_tag
        fileinfo[:title] = tag.title.nil? ? File.basename(filepath, '.mp3') : tag.title
        properties = mp3_file.audio_properties
        fileinfo[:bitrate] = properties.bitrate.to_s + 'kbps'
        fileinfo[:duration] = (Time.parse("1/1") + properties.length).strftime("%H:%M:%S")
      end
      @list << fileinfo
    end
    render :layout => false
  end
  
  def rehearsal_prev
    urlbase = 'http://hal.mu/rehearsal_recs/'
    files = `ls /home/yu/www/priv.hal.mu/rehearsal_recs/*.mp3 -t`.split "\n"
    @list = []
    files.each do |filepath|
      fileinfo = {}
      file = File.stat filepath
      fileinfo[:update] = file.mtime
      if @lastbuilddate.nil?
        @lastbuilddate = file.mtime
      end
      fileinfo[:url] = urlbase + File.basename(filepath)
      fileinfo[:file] = File.basename(filepath)
      fileinfo[:length] = file.size
      TagLib::MPEG::File.open(filepath) do |mp3_file|
        tag = mp3_file.id3v2_tag
        fileinfo[:title] = tag.title.nil? ? File.basename(filepath, '.mp3') : tag.title
        properties = mp3_file.audio_properties
        fileinfo[:bitrate] = properties.bitrate.to_s + 'kbps'
        fileinfo[:duration] = (Time.parse("1/1") + properties.length).strftime("%H:%M:%S")
      end
      @list << fileinfo
    end
    render :layout => false
  end

  def concert
    urlbase = 'http://hal.mu/concert_recs/'
    files = `ls /home/yu/www/priv.hal.mu/recs/*.mp3 -t`.split "\n"
    @list = []
    files.each do |filepath|
      fileinfo = {}
      file = File.stat filepath
      fileinfo[:update] = file.mtime
      if @lastbuilddate.nil?
        @lastbuilddate = file.mtime
      end
      fileinfo[:url] = urlbase + File.basename(filepath)
      fileinfo[:file] = File.basename(filepath)
      fileinfo[:length] = file.size
      TagLib::MPEG::File.open(filepath) do |mp3_file|
        tag = mp3_file.id3v2_tag
        fileinfo[:title] = tag.title.nil? ? File.basename(filepath, '.mp3') : tag.title
        fileinfo[:album] = tag.album.nil? ? '' : tag.album
        properties = mp3_file.audio_properties
        fileinfo[:bitrate] = properties.bitrate.to_s + 'kbps'
        fileinfo[:duration] = (Time.parse("1/1") + properties.length).strftime("%H:%M:%S")
      end
      @list << fileinfo
    end
    p @list
    render :layout => false
  end

end
