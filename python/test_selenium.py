from selenium import webdriver
import time
from time import sleep
from selenium.webdriver.common.by import By


def test_google_search():
    driver = webdriver.Chrome()
    driver.get('https://www.google.com')
    driver.maximize_window()
    title = "Google"
    assert title == driver.title

    search_text = "LambdaTest"
    # search_box = driver.find_element_by_xpath("//input[@name='q']")
    search_box = driver.find_element(By.XPATH, "//input[@name='q']")
    search_box.send_keys(search_text)

    # Using Sleep is not a good programming practice
    # Only used here for demonstration purpose
    time.sleep(5)
    search_box.submit()

    time.sleep(5)

    # Click on the LambdaTest HomePage Link
    # This test will fail as the titles will not match
    title = "Most Powerful Cross Browser Testing Tool Online | LambdaTest"
    # lt_link = driver.find_element_by_xpath("//h3[.='LambdaTest: Most Powerful Cross Browser Testing Tool Online']")
    lt_link = driver.find_element(By.XPATH, "//h3[.='LambdaTest: Most Powerful Cross Browser Testing Tool Online']")
    lt_link.click()

    time.sleep(5)
    assert title == driver.title
    time.sleep(2)

    # Release the resources in the teardown function
    print("TearDown initiated")
    driver.quit()