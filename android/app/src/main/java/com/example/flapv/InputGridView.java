package com.example.flapv;

import android.content.Context;
import android.graphics.Color;
import android.util.Log;
import android.view.Gravity;
import android.view.MotionEvent;
import android.widget.LinearLayout;
import android.view.ViewGroup.LayoutParams;
import android.view.View;
import android.widget.TextView;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.platform.PlatformView;
import java.util.Map;
import java.util.Random;

class InputGridView implements PlatformView {
  private final String TAG = "InputGridView";
  private final LinearLayout row;
  private int id;

  private int getRandomColor() {
    Random rnd = new Random();
    return Color.argb(255, rnd.nextInt(256), rnd.nextInt(256), rnd.nextInt(256));
  }

  InputGridView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams) {
    this.id = id;

    // We are building a 3x3 grid.
    row = new LinearLayout(context);
    row.setOrientation(LinearLayout.HORIZONTAL);
    row.setShowDividers(0);

    for (int x = 0; x < 3; x++) {
      final LinearLayout col = new LinearLayout(context);
      col.setOrientation(LinearLayout.VERTICAL);
      col.setShowDividers(0);

      for (int y = 0; y < 3; y++) {
        final TextView textView = new TextView(context);
        textView.setTextSize(20);
        textView.setLayoutParams(new LayoutParams(250, 250));
        final int cell = y * 3 + x;
        textView.setText(" " + cell + " ");
        textView.setBackgroundColor(getRandomColor());
        textView.setGravity(Gravity.CENTER_VERTICAL | Gravity.CENTER_HORIZONTAL);
        textView.setOnTouchListener(new View.OnTouchListener() {
          @Override
          public boolean onTouch(View v, MotionEvent event) {
            if (event.getAction() == MotionEvent.ACTION_UP) {
              textView.setBackgroundColor(getRandomColor());
              final String cellAsString = textView.getText().toString().trim();
              final int newCell = Integer.parseInt(cellAsString) + 1;
              textView.setText(" " + newCell + " ");
            }
            Log.e(TAG, "#onTouch " + event.getAction() + " cell=" + cell);
            return true;
          }
        });

        col.addView(textView);
      }

      row.addView(col);
    }
  }

  @NonNull
  @Override
  public View getView() {
    return row;
  }

  @Override
  public void onFlutterViewAttached(@NonNull View flutterView) {
    Log.e(TAG, "#InputGridView#onFlutterViewAttached, " + flutterView);
  }

  @Override
  public void onFlutterViewDetached() {
    Log.e(TAG, "#InputGridView#onFlutterViewDetached");
  }

  @Override
  public void dispose() {
    Log.e(TAG, "#InputGridView#dispose~~ id=" + id);
  }
}

class InputGridViewFactory extends PlatformViewFactory {
  InputGridViewFactory() {
    super(StandardMessageCodec.INSTANCE);
  }

  @NonNull
  @Override
  public PlatformView create(@NonNull Context context, int id, @Nullable Object args) {
    final Map<String, Object> creationParams = (Map<String, Object>) args;
    return new InputGridView(context, id, creationParams);
  }
}
