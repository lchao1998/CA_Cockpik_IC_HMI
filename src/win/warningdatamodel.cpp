#include "warningdatamodel.h"

const char* warning_table[][2] = {
    "", "",
    "../images/warning/driver_seat_warning.png", "主驾驶座位请系好安全带",
    "../images/warning/airbag_failure.png", "安全气囊故障，请及时维修"
};

WarningDataModel::WarningDataModel(int updateInterval, QObject *parent)
    : DataModel{updateInterval, parent},
      m_testval(0),
      m_count(0)
{
}

void WarningDataModel::updateData()
{
    if (m_testval == 0) {
        if (m_count > 5) {
            m_count = 0;
            m_testval++;
        } else {
            m_count++;
        }
    } else {
        if (m_count > 4) {
            m_count = 0;
            m_testval++;
        } else {
            m_count++;
        }
        if (m_testval > 2) {
            m_testval = 0;
        }
    }
    emit warning_visibilityChanged();
    emit warning_iconChanged();
    emit warning_messageChanged();
}

DATA_PROPERTY_IMPLEMENT(WarningDataModel, warning_visibility, bool)
{
    return m_testval != 0;
}

DATA_PROPERTY_IMPLEMENT(WarningDataModel, warning_icon, QString)
{
    return QString(warning_table[m_testval][0]);
}

DATA_PROPERTY_IMPLEMENT(WarningDataModel, warning_message, QString)
{
    return QString(warning_table[m_testval][1]);
}
