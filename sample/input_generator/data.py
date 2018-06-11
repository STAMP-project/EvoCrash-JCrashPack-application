class ProjectData:
    projects=[{"id":"0","name":"xwiki","package":"xwiki"}]
    def findProject(self,id):
        result = {}
        for p in self.projects:
            if p["id"] == id:
                result = p
                break
        return result
class CaseData:
    cases = [
        {"id": "10", "project": "0", "name": "XWIKI-13031", "version": "7.4", "fixed": "1","fixed_version": "7.4.1", "buggy_frame": "2"},

             ]



class OtherData:
    p_functional_mocking = [0.8]
    functional_mocking_percent = [0.5]
    search_budget = [62328]
    population = [100]
    repeat = 10
