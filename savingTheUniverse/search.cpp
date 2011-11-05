#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SE_MAX_ENGINE_NAME  (100 + 1)
#define SE_MAX_ENGINES      100
#define SE_MAX_QUERIES      1000

class CSearch
{
public:
    CSearch();
    ~CSearch();

    void doSearch();
private:
    int doCase();
    void resetData();
    void readEngines();
    void readQueries();
    int findSwitches();
    int findDistance(int nEngine, int nQuery);

    int m_nNumEngines;
    int m_nNumQueries;

    char m_szEngineList[SE_MAX_ENGINES][SE_MAX_ENGINE_NAME];
    char m_szQueryList[SE_MAX_QUERIES][SE_MAX_ENGINE_NAME];
};

CSearch::CSearch()
{
}

CSearch::~CSearch()
{
}

void CSearch::resetData()
{
    memset(m_szEngineList, 0, sizeof(m_szEngineList));
    memset(m_szQueryList, 0, sizeof(m_szQueryList));
}

void CSearch::readEngines()
{
    int nEngine;
    scanf("%i\n", &m_nNumEngines);
    for (nEngine = 0; nEngine < m_nNumEngines; nEngine++)
    {
        gets(m_szEngineList[nEngine]);
    }
}

void CSearch::readQueries()
{
    int nQuery;
    scanf("%i\n", &m_nNumQueries);
    for (nQuery = 0; nQuery < m_nNumQueries; nQuery++)
    {
        gets(m_szQueryList[nQuery]);
    }
}

int CSearch::findDistance(int nEngine, int nQuery)
{
    for (; nQuery < m_nNumQueries; nQuery++)
    {
        if (strcmp(m_szEngineList[nEngine], m_szQueryList[nQuery]) == 0)
        {
            break;
        }
    }
    return nQuery;
}

int CSearch::findSwitches()
{
    int nEngine;
    int nQuery = 0;
    int nTmp;
    int nLongest = 0;
    int nSwitches = 0;

    do
    {
        for (nEngine = 0; nEngine < m_nNumEngines; nEngine++)
        {
            nTmp = findDistance(nEngine, nQuery);
            if (nTmp > nLongest)
            {
                nLongest = nTmp;
            }
        }
        if (nLongest != nQuery)
        {
            if (nQuery != 0)
            {
                nSwitches++;
            }
            nQuery = nLongest;
        }
    } while (nQuery < m_nNumQueries);
    return (nSwitches < 0) ? 0 : nSwitches;
}

int CSearch::doCase()
{
    resetData();
    readEngines();
    readQueries();

    return findSwitches();
}

void CSearch::doSearch()
{
    int nTotalCases;
    int nCase;
    scanf("%i\n", &nTotalCases);
    for (nCase = 0; nCase < nTotalCases; nCase++)
    {
        printf("Case #%i: %i\n", nCase + 1, doCase());
    }
}

int main()
{
    CSearch *pSearch;
    pSearch = new(CSearch);
    if (pSearch)
    {
        pSearch->doSearch();
        delete(pSearch);
    }
    return 0;
}
