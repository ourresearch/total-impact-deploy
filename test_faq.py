from selenium import webdriver
import unittest

type_of_test = 'local_phantomjs'
# type_of_test = 'local_firefox'
# type_of_test = 'sauce_windows_chrome'


def get_web_driver(type_of_test):
    if type_of_test == 'local_firefox':
        web_driver = webdriver.Firefox()
        host = "http://localhost:5000"

    elif type_of_test == 'local_phantomjs':     
        web_driver = webdriver.PhantomJS('phantomjs')
        host = "http://localhost:5000"

    elif type_of_test == 'sauce_windows_chrome':
        # code for others is here: https://saucelabs.com/platforms
        desired_capabilities = webdriver.DesiredCapabilities.CHROME
        desired_capabilities['version'] = '31'
        desired_capabilities['platform'] = "Windows 8.1"
        desired_capabilities['name'] = 'Testing Selenium 2 in Python at Sauce'
        web_driver = webdriver.Remote(
            desired_capabilities=desired_capabilities,
            command_executor="http://impactstory:1aa405d4-4f50-4739-a3fd-17301c407baf@ondemand.saucelabs.com:80/wd/hub"
        )
        host = "http://staging-impactstory.org"

    return ({"web_driver": web_driver, "host": host})



class test_faq(unittest.TestCase):

    def setUp(self):
        driver_attributes = get_web_driver(type_of_test)
        self.host = driver_attributes["host"]
        self.wd = driver_attributes["web_driver"]
        self.wd.implicitly_wait(60)
    
    def test_faq(self):
        self.wd.get(self.host + "/faq")
        success = "The number of readers who have added the article to their libraries" in self.wd.find_element_by_tag_name("html").text
        self.assertTrue(success)
    
    def tearDown(self):
        self.wd.quit()
        try:
            print("Link to your job: https://saucelabs.com/jobs/%s" % self.wd.session_id)
        except AttributeError:
            pass # no session_id, maybe because was local


if __name__ == '__main__':
    unittest.main()
