#!/usr/bin/env python3

import os
import sys
import time

import wget

from bs4 import BeautifulSoup

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By

def init_driver():
    return webdriver.Safari()

def login_webx(driver, email, random_url):
    driver.get(random_url)
    WebDriverWait(driver, 50).until(EC.visibility_of_element_located((By.ID, "IDToken1")))
    WebDriverWait(driver, 50).until(EC.visibility_of_element_located((By.ID, "IDButton2")))
    text_area = driver.find_element_by_id('IDToken1')
    text_area.send_keys(email)
    
    submit_button = driver.find_element_by_id('IDButton2')
    submit_button.click()
    
def login_polimi(driver, codicepersone, password):
    WebDriverWait(driver, 50).until(EC.visibility_of_element_located((By.ID, "login")))
    WebDriverWait(driver, 50).until(EC.visibility_of_element_located((By.ID, "password")))
    text_area = driver.find_element_by_id('login')
    text_area.send_keys(codicepersone)
    time.sleep(1)
    pass_area = driver.find_element_by_id('password')
    pass_area.send_keys(password)
    time.sleep(1)
    
    submit_button = driver.find_element_by_name("evn_conferma")
    submit_button.click()
    
    time.sleep(3)
    
def load_url(driver, url):
    driver.get(url)
    WebDriverWait(driver, 50).until(EC.visibility_of_element_located((By.ID, "screen_html5_api"))) # waits till the element with the specific id appears
    src = driver.page_source
    return src

def write_to_file(filename, text):
    f = open(filename, "w+")
    f.write(text)
    f.close()
    
def printInfoDownload(videos):
    print("Downloading the following videos")
    for video in videos:
        print(video)

if __name__ == '__main__':
    if len(sys.argv) < 5:
        print("Not enough arguments")
        sys.exit(1)
    printInfoDownload(sys.argv[4:])
    
    driver = init_driver()
    login_webx(driver, sys.argv[1], sys.argv[4])
    login_polimi(driver, sys.argv[2], sys.argv[3])
    
    counter = 0
    filename = 'file'
    for url in sys.argv[4:]:
        src = load_url(driver, url)
        write_to_file(filename+str(counter)+'.html', src)
        counter += 1
    
    driver.close()
    sys.exit(0)