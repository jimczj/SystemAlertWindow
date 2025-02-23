package in.jvapps.system_alert_window.views;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.GradientDrawable;
import android.view.Gravity;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.List;
import java.util.Map;

import in.jvapps.system_alert_window.models.Decoration;
import in.jvapps.system_alert_window.models.Padding;
import in.jvapps.system_alert_window.utils.Commons;
import in.jvapps.system_alert_window.utils.UiBuilder;

import static in.jvapps.system_alert_window.utils.Constants.KEY_COLUMNS;
import static in.jvapps.system_alert_window.utils.Constants.KEY_DECORATION;
import static in.jvapps.system_alert_window.utils.Constants.KEY_GRAVITY;
import static in.jvapps.system_alert_window.utils.Constants.KEY_PADDING;
import static in.jvapps.system_alert_window.utils.Constants.KEY_ROWS;
import static in.jvapps.system_alert_window.utils.Constants.KEY_TEXT;

public class BodyView {
    private final Map<String, Object> bodyMap;
    private final Context context;
    private final UiBuilder uiBuilder = UiBuilder.getInstance();
    private final int bgColor;

    public BodyView(Context context, Map<String, Object> bodyMap, int bgColor) {
        this.context = context;
        this.bodyMap = bodyMap;
        this.bgColor = bgColor;
    }

    public LinearLayout getView() {
        LinearLayout linearLayout = new LinearLayout(context);
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        Decoration decoration = uiBuilder.getDecoration(context, Commons.getMapFromObject(bodyMap, KEY_DECORATION));
        if(decoration != null){
            GradientDrawable gd = uiBuilder.getGradientDrawable(decoration);
            linearLayout.setBackground(gd);
        } else{
            linearLayout.setBackgroundColor(bgColor);
        }
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT);
        Commons.setMargin(context, params, bodyMap);
        linearLayout.setLayoutParams(params);
        Padding padding = uiBuilder.getPadding(context, bodyMap.get(KEY_PADDING));
        linearLayout.setPadding(padding.getLeft(), padding.getTop(), padding.getRight(), padding.getBottom());
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> rowsMap = (List<Map<String, Object>>) bodyMap.get(KEY_ROWS);
        if (rowsMap != null) {
            for (int i = 0; i < rowsMap.size(); i++) {
                Map<String, Object> row = rowsMap.get(i);
                linearLayout.addView(createRow(row));
            }
        }
        return linearLayout;
    }

    private View createRow(Map<String, Object> rowMap) {
        LinearLayout linearLayout = new LinearLayout(context);
        linearLayout.setOrientation(LinearLayout.HORIZONTAL);
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT);
        Commons.setMargin(context, params, rowMap);
        linearLayout.setLayoutParams(params);
        linearLayout.setGravity(Commons.getGravity((String) rowMap.get(KEY_GRAVITY), Gravity.START));
        Padding padding = uiBuilder.getPadding(context, rowMap.get(KEY_PADDING));
        linearLayout.setPadding(padding.getLeft(), padding.getTop(), padding.getRight(), padding.getBottom());
        Decoration decoration = uiBuilder.getDecoration(context, Commons.getMapFromObject(rowMap, KEY_DECORATION));
        if(decoration != null){
            GradientDrawable gd = uiBuilder.getGradientDrawable(decoration);
            linearLayout.setBackground(gd);
        }
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> columnsMap = (List<Map<String, Object>>) rowMap.get(KEY_COLUMNS);
        if (columnsMap != null) {
            for (int j = 0; j < columnsMap.size(); j++) {
                Map<String, Object> column = columnsMap.get(j);
                linearLayout.addView(createColumn(column));
            }
        }
        return linearLayout;
    }

    private View createColumn(Map<String, Object> columnMap){
        LinearLayout columnLayout = new LinearLayout(context);
        columnLayout.setOrientation(LinearLayout.HORIZONTAL);
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT);
        Commons.setMargin(context, params, columnMap);
        columnLayout.setLayoutParams(params);
        Padding padding = uiBuilder.getPadding(context, columnMap.get(KEY_PADDING));
        columnLayout.setPadding(padding.getLeft(), padding.getTop(), padding.getRight(), padding.getBottom());
        Decoration decoration = uiBuilder.getDecoration(context, Commons.getMapFromObject(columnMap, KEY_DECORATION));
        if(decoration != null){
            GradientDrawable gd = uiBuilder.getGradientDrawable(decoration);
            columnLayout.setBackground(gd);
        }
        TextView textView = uiBuilder.getTextView(context, Commons.getMapFromObject(columnMap, KEY_TEXT));
        columnLayout.addView(textView);
        return columnLayout;
    }
}
