#ifndef WARNINGDATAMODEL_H
#define WARNINGDATAMODEL_H

#include <datamodel.h>
#include <QString>

class WarningDataModel : public DataModel
{
    Q_OBJECT

public:
    explicit WarningDataModel(int updateInterval = 500, QObject *parent = nullptr);

protected:
    void updateData() override;

    DATA_PROPERTY_DEFINE(warning_visibility, bool)
    DATA_PROPERTY_DEFINE(warning_icon, QString)
    DATA_PROPERTY_DEFINE(warning_message, QString)

signals:
    CHANGED_SIGNAL_DEFINE(warning_visibility)
    CHANGED_SIGNAL_DEFINE(warning_icon)
    CHANGED_SIGNAL_DEFINE(warning_message)

private:
    void updateIndex();

    unsigned int m_index;
};

#endif // WARNINGDATAMODEL_H
