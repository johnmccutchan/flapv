package com.example.flapv;

import android.content.Context;
import android.graphics.Color;
import android.util.Log;
import android.view.Gravity;
import android.view.MotionEvent;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import android.view.View;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.platform.PlatformView;
import java.util.Map;
import java.util.Random;

class StaticTextView implements PlatformView {
  private final String TAG = "StaticTextView";
  @NonNull private final TextView textView;
  private int id;

  private int getRandomColor() {
    Random rnd = new Random();
    return Color.argb(255, rnd.nextInt(256), rnd.nextInt(256), rnd.nextInt(256));
  }

  StaticTextView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams) {
    this.id = id;
    textView = new TextView(context);
    textView.setTextSize(20);

    textView.setBackgroundColor(getRandomColor());
    textView.setGravity(Gravity.CENTER_VERTICAL | Gravity.CENTER_HORIZONTAL);

    StringBuilder sb = new StringBuilder();
    sb.append("Static Text View (id: " + id + ")");
    textView.setTextColor(Color.BLACK);
    textView.setText(sb.toString());

    textView.setOnTouchListener(new View.OnTouchListener() {
      @Override
      public boolean onTouch(View v, MotionEvent event) {
        if (event.getAction() == MotionEvent.ACTION_UP) {
          textView.setBackgroundColor(getRandomColor());
        }
        Log.e(TAG, "#onTouch " + event.getAction());
        return true;
      }
    });
  }

  @NonNull
  @Override
  public View getView() {
    return textView;
  }

  @Override
  public void onFlutterViewAttached(@NonNull View flutterView) {
    Log.e(TAG, "#StaticTextView#onFlutterViewAttached, " + flutterView);
  }

  @Override
  public void onFlutterViewDetached() {
    Log.e(TAG, "#StaticTextView#onFlutterViewDetached");
  }

  @Override
  public void dispose() {
    Log.e(TAG, "#StaticTextView#dispose~~ id=" + id);
  }
}

class StaticTextViewFactory extends PlatformViewFactory {
  StaticTextViewFactory() {
    super(StandardMessageCodec.INSTANCE);
  }

  @NonNull
  @Override
  public PlatformView create(@NonNull Context context, int id, @Nullable Object args) {
    final Map<String, Object> creationParams = (Map<String, Object>) args;
    return new StaticTextView(context, id, creationParams);
  }
}
