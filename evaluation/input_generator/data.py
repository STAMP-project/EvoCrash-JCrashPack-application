class ProjectData:
    projects=[{"id":"0","name":"xwiki","package":"xwiki"},
                {"id":"1","name":"chart","package":"chart"},
                {"id":"2","name":"lang","package":"lang3"},
                {"id":"3","name":"math","package":"math3"},
                {"id":"4","name":"mockito","package":"mockito"},
                {"id":"5","name":"time","package":"time"},
                {"id": "6", "name": "es", "package": "elasticsearch"}]
    def findProject(self,id):
        result = {}
        for p in self.projects:
            if p["id"] == id:
                result = p
                break
        return result
class CaseData:
    cases = [{"id": "113", "project": "0", "name": "XWIKI-12482", "version": "7.2-milestone-3", "fixed": "1","fixed_version": "7.2-rc-1", "buggy_frame": "1"},
             {"id": "0", "project": "0", "name": "XWIKI-13708", "version": "8.2.1", "fixed": "1","fixed_version": "8.3-rc-1", "buggy_frame": "1"},
             {"id": "12", "project": "0", "name": "XWIKI-14319", "version": "9.4-rc-1", "fixed": "0","fixed_version": "", "buggy_frame": ""},
             {"id": "3", "project": "0", "name": "XWIKI-14475", "version": "9.5", "fixed": "1","fixed_version": "9.5.1", "buggy_frame": "1"},
             {"id": "8", "project": "0", "name": "XWIKI-13616", "version": "8.2", "fixed": "1","fixed_version": "8.2.2", "buggy_frame": "5"},
             {"id": "13", "project": "0", "name": "XWIKI-14612", "version": "8.4", "fixed": "1","fixed_version": "9.7-rc-1", "buggy_frame": "unknown"},
             {"id": "7", "project": "0", "name": "XCOMMONS-928", "version": "7.4.2", "fixed": "1","fixed_version": "7.4.3", "buggy_frame": "5"},
             {"id": "14", "project": "0", "name": "XRENDERING-418", "version": "7.3", "fixed": "0", "fixed_version": "","buggy_frame": ""},
             {"id": "18", "project": "0", "name": "XWIKI-13372", "version": "7.4.2", "fixed": "1","fixed_version": "7.4.6", "buggy_frame": "2"},
             {"id": "30", "project": "0", "name": "XWIKI-13617", "version": "8.2.1", "fixed": "1","fixed_version": "8.3-milestone-1", "buggy_frame": "3"},
             {"id": "37", "project": "1", "name": "CHART-4b", "version": "4b", "fixed": "1", "fixed_version": "4f","buggy_frame": "6"},
             {"id": "44", "project": "2", "name": "LANG-20b", "version": "20b", "fixed": "1", "fixed_version": "20f","buggy_frame": "3"},
             {"id": "47", "project": "2", "name": "LANG-33b", "version": "33b", "fixed": "1", "fixed_version": "33f","buggy_frame": "1"},
             {"id": "51", "project": "2", "name": "LANG-39b", "version": "39b", "fixed": "1", "fixed_version": "39f","buggy_frame": "2"},
             {"id": "54", "project": "2", "name": "LANG-47b", "version": "47b", "fixed": "1", "fixed_version": "47f","buggy_frame": "1"},
             {"id": "57", "project": "2", "name": "LANG-57b", "version": "57b", "fixed": "1", "fixed_version": "57f","buggy_frame": "1"},
             {"id": "73", "project": "3", "name": "MATH-4b", "version": "4b", "fixed": "1", "fixed_version": "4f","buggy_frame": "3"},
             {"id": "78", "project": "3", "name": "MATH-70b", "version": "70b", "fixed": "1", "fixed_version": "70f","buggy_frame": "3"},
             {"id": "80", "project": "3", "name": "MATH-79b", "version": "79b", "fixed": "1", "fixed_version": "79f","buggy_frame": "2"},
             {"id": "98", "project": "4", "name": "MOCKITO-36b", "version": "36b", "fixed": "1", "fixed_version": "36f","buggy_frame": "1"},
             {"id": "99", "project": "4", "name": "MOCKITO-38b", "version": "38b", "fixed": "1", "fixed_version": "38f","buggy_frame": "2"},
             {"id": "102", "project": "6", "name": "ES-27055", "version": "5.6.3", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "103", "project": "6", "name": "ES-27046", "version": "5.5.2", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "104", "project": "6", "name": "ES-25920", "version": "5.5.1", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "105", "project": "6", "name": "ES-24968", "version": "5.4.0", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "106", "project": "6", "name": "ES-24928", "version": "5.4.0", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "107", "project": "6", "name": "ES-24259", "version": "5.3.1", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "112", "project": "6", "name": "ES-21906", "version": "5.0.1", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "115", "project": "6", "name": "ES-20408", "version": "2.4.0", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "17", "project": "0", "name": "XWIKI-13196", "version": "7.4.2", "fixed": "0", "fixed_version": "","buggy_frame": ""},
             {"id": "31", "project": "0", "name": "XWIKI-13942", "version": "8.4", "fixed": "1","fixed_version": "8.4.4", "buggy_frame": "unknown"},
             {"id": "36", "project": "1", "name": "CHART-13b", "version": "13b", "fixed": "1", "fixed_version": "13f","buggy_frame": "6"},
             {"id": "46", "project": "2", "name": "LANG-2b", "version": "2b", "fixed": "1", "fixed_version": "2f","buggy_frame": "1"},
             {"id": "56", "project": "2", "name": "LANG-54b", "version": "54b", "fixed": "1", "fixed_version": "54f","buggy_frame": "1"},
             {"id": "58", "project": "2", "name": "LANG-5b", "version": "5b", "fixed": "1", "fixed_version": "5f","buggy_frame": "1"},
             {"id": "86", "project": "3", "name": "MATH-90b", "version": "90b", "fixed": "1", "fixed_version": "90f","buggy_frame": "1"},
             {"id": "87", "project": "3", "name": "MATH-95b", "version": "95b", "fixed": "1", "fixed_version": "95f","buggy_frame": "4"},
             {"id": "88", "project": "3", "name": "MATH-97b", "version": "97b", "fixed": "1", "fixed_version": "97f","buggy_frame": "1"},
             {"id": "108", "project": "5", "name": "TIME-20b", "version": "20b", "fixed": "1", "fixed_version": "20f","buggy_frame": "1"},
             {"id": "109", "project": "5", "name": "TIME-2b", "version": "2b", "fixed": "1", "fixed_version": "2f","buggy_frame": "2"},
             {"id": "112", "project": "5", "name": "TIME-8b", "version": "8b", "fixed": "1", "fixed_version": "8f","buggy_frame": "1"},
             {"id": "114", "project": "6", "name": "ES-20333", "version": "2.3.5", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "116", "project": "6", "name": "ES-26651", "version": "5.5.3", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "118", "project": "6", "name": "ES-26184", "version": "5.5.1", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "120", "project": "6", "name": "ES-21457", "version": "5.0.0", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "122", "project": "6", "name": "ES-20045", "version": "5.0.0-alpha4", "fixed": "","fixed_version": "", "buggy_frame": ""},
             {"id": "39", "project": "2", "name": "LANG-12b", "version": "12b", "fixed": "1", "fixed_version": "12f","buggy_frame": "2"},
             {"id": "60", "project": "2", "name": "LANG-9b", "version": "9b", "fixed": "1", "fixed_version": "9f","buggy_frame": "10"},
             {"id": "61", "project": "3", "name": "MATH-100b", "version": "100b", "fixed": "1", "fixed_version": "100f","buggy_frame": "1"},
             {"id": "70", "project": "3", "name": "MATH-3b", "version": "3b", "fixed": "1", "fixed_version": "3f","buggy_frame": "1"},
             {"id": "81", "project": "3", "name": "MATH-81b", "version": "81b", "fixed": "1", "fixed_version": "81f","buggy_frame": "6"},
             {"id": "89", "project": "3", "name": "MATH-98b", "version": "98b", "fixed": "1", "fixed_version": "98f","buggy_frame": "1"},
             {"id": "97", "project": "4", "name": "MOCKITO-34b", "version": "34b", "fixed": "1", "fixed_version": "34f","buggy_frame": "1"},
             {"id": "100", "project": "4", "name": "MOCKITO-3b", "version": "3b", "fixed": "1", "fixed_version": "3f","buggy_frame": "12"},
             {"id": "102", "project": "6", "name": "ES-24674", "version": "5.3.0", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "104", "project": "6", "name": "ES-23324", "version": "5.1.1", "fixed": "", "fixed_version": "","buggy_frame": ""},
             {"id": "10", "project": "0", "name": "XWIKI-13031", "version": "7.4", "fixed": "1","fixed_version": "7.4.1", "buggy_frame": "2"},
             {"id": "4", "project": "0", "name": "XWIKI-13916", "version": "8.4", "fixed": "1","fixed_version": "8.4.2", "buggy_frame": "1"},
             {"id": "114", "project": "0", "name": "XWIKI-12584", "version": "7.2-milestone-2", "fixed": "1","fixed_version": "7.2", "buggy_frame": "2"},
             {"id": "68", "project": "3", "name": "MATH-32b", "version": "32b", "fixed": "1", "fixed_version": "32f","buggy_frame": "10"},
             {"id": "84", "project": "3", "name": "MATH-89b", "version": "89b", "fixed": "1", "fixed_version": "89f","buggy_frame": "1"},
             {"id": "91", "project": "4", "name": "MOCKITO-12b", "version": "12b", "fixed": "1", "fixed_version": "12f","buggy_frame": "1"},
             {"id": "101", "project": "4", "name": "MOCKITO-4b", "version": "4b", "fixed": "1", "fixed_version": "4f","buggy_frame": "4"},
             {"id": "123", "project": "0", "name": "XWIKI-14152", "version": "8.4.4", "fixed": "1","fixed_version": "8.4.5", "buggy_frame": "unknown"},
             {"id": "42", "project": "2", "name": "LANG-19b", "version": "19b", "fixed": "1", "fixed_version": "19f","buggy_frame": "4"},
             {"id": "45", "project": "2", "name": "LANG-27b", "version": "27b", "fixed": "1", "fixed_version": "27f","buggy_frame": "3"},
             {"id": "52", "project": "2", "name": "LANG-44b", "version": "44b", "fixed": "1", "fixed_version": "44f","buggy_frame": "2"},
             {"id": "53", "project": "2", "name": "LANG-45b", "version": "45b", "fixed": "1", "fixed_version": "45f","buggy_frame": "2"},
             {"id": "55", "project": "2", "name": "LANG-51b", "version": "51b", "fixed": "1", "fixed_version": "51f","buggy_frame": "2"},
             {"id": "59", "project": "2", "name": "LANG-6b", "version": "6b", "fixed": "1", "fixed_version": "6f","buggy_frame": "5"},
             {"id": "62", "project": "3", "name": "MATH-101b", "version": "101b", "fixed": "1", "fixed_version": "101f","buggy_frame": "2"},
             {"id": "62", "project": "6", "name": "ES-22997", "version": "22997", "fixed": "2.4.1", "fixed_version": "","buggy_frame": ""}
             ]



class OtherData:
    p_functional_mocking = [0.8]
    functional_mocking_percent = [0.5]
    search_budget = [62328]
    population = [100]
    repeat = 10
