# watch_pyx.py
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from pathlib import Path
import time

class PyxHandler(FileSystemEventHandler):
    def on_created(self, event):
        if event.is_directory:
            return
        path = Path(event.src_path)
        if path.suffix == ".pyx":
            pxd = path.with_suffix(".pxd")
            if not pxd.exists():
                pxd.touch()
                print(f"Created {pxd}")

if __name__ == "__main__":
    observer = Observer()
    observer.schedule(PyxHandler(), ".", recursive=True)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
