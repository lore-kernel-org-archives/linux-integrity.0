Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16149C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 21:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B364E206C0
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 21:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pt2GihDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfBVVk3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:40:29 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35686 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVVk3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 16:40:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id z19so3153603otm.2
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 13:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g+NBlw+vvLpX8lYCfhaqWv21sh0MJ5jKZ5ZGdZOVVRA=;
        b=pt2GihDapHoD7BB8UV2SEGQtQEHGJbUSdDCD5dJ4J0KLInXubH1QEpRkJ5o4GVMzjL
         6UeDDtNvzo97AusNtUxunz0364T2Owele/irsmCEJZck+ajrLdsukmgFhDdFvDkoOL2a
         rgak72Ujz1AZVh4d8k4bAZIso3to66O3jRIo2ieoja6YmFunnpmK+CVRmOe5GLXa7DYD
         HJsuk3OTxon5F58xuVGok6gpqYcVVhEsbxkj7Eh9yPS+sytCwZ0R2dwXMXLlR8AQ8rqC
         J8qRJfXZK5o3mwDufWO1n8m8T7P986l8ujByhHB//5QdAnSdlHiJCgI29GcuMtzFBWtX
         iepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g+NBlw+vvLpX8lYCfhaqWv21sh0MJ5jKZ5ZGdZOVVRA=;
        b=T0rNTSJmSB+17DttD1keo73Oiev1lEG49q9ew5XMC2LeL1VpVDOiKqcEHvFgXTZJh0
         UuEEJ/eWx4whRng9WGcy9vd8a3XIxZ8ZBJenMPrCEsuGY21duth6hmgN8nKgG+azojLJ
         +p6PUWH0YiR/bImtcpmEioIeDllzyKveU/QPPYUpCghyzw+xGQG0ZjSFot6Tbwys7G8r
         Bzx/quUHzZCfH4N85Vu6RS0mKNhw4qxqWMnyFfgPzQeMos7BXjRkLizwI7wJv/DTXHEn
         oQ5kuYTB1GpSVmUz8Gn/BY0RpKewVsdRrpGZh0b/gk3+dyXDlqrqYJi1Gog2OkGtOQuN
         dXWA==
X-Gm-Message-State: AHQUAuZhreRAm6tHAAOGnBwQx+GSmoMnR08JnVec4pCoAHWrlvZjJp16
        /WWLtbr4OXmJ/XB1/GzTYz8=
X-Google-Smtp-Source: AHgI3IZPJfIQzqmw0OIiADt0YuYReJ0INqFsOZzDXnAmRJkn1cNN7vRwhVwS8iEifqKoayDGQysSDg==
X-Received: by 2002:a9d:7685:: with SMTP id j5mr4114634otl.150.1550871627506;
        Fri, 22 Feb 2019 13:40:27 -0800 (PST)
Received: from ?IPv6:2600:1700:dc40:8a50:bd50:a563:2590:39f6? ([2600:1700:dc40:8a50:bd50:a563:2590:39f6])
        by smtp.gmail.com with ESMTPSA id k23sm1039815oih.33.2019.02.22.13.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 13:40:26 -0800 (PST)
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <20190222003207-mutt-send-email-mst@kernel.org>
From:   David Tolnay <dtolnay@gmail.com>
Message-ID: <461bd10a-0a30-81e3-63b4-0798eb75b9e7@gmail.com>
Date:   Fri, 22 Feb 2019 13:40:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222003207-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/21/19 9:51 PM, Michael S. Tsirkin wrote:
> On Thu, Feb 21, 2019 at 06:14:02PM -0800, David Tolnay wrote:
>> Add a config TCG_VIRTIO_VTPM which enables a driver providing the guest
>> kernel side of TPM over virtio.
>>
>> Use case: TPM support is needed for performing trusted work from within
>> a virtual machine launched by Chrome OS.
>>
>> Tested inside crosvm, the Chrome OS virtual machine monitor. Crosvm's
>> implementation of the virtio TPM device can be found in these two source
>> files:
>>
>> - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/devices/src/virtio/tpm.rs
>> - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/tpm2/src/lib.rs
>>
>> and is currently backed by the libtpm2 TPM simulator:
>>
>> - https://chromium.googlesource.com/chromiumos/third_party/tpm2/
>>
>> Reviewed-on: https://chromium-review.googlesource.com/1387655
>> Reviewed-by: Andrey Pronin <apronin@chromium.org>
>> Tested-by: David Tolnay <dtolnay@gmail.com>
>> Signed-off-by: David Tolnay <dtolnay@gmail.com>
>> ---
>> UNRESOLVED:
>> The driver assumes virtio device number VIRTIO_ID_TPM=31. If there is
>> interest in accepting a virtio TPM driver into the kernel, the Chrome OS
>> team will coordinate with the OASIS virtio technical committee to secure
>> an agreed upon device number and include it in a later patchset.
> 
> I am not a tpm expert but I don't see why not.
> 
> 
>>  drivers/char/tpm/Kconfig      |   9 +
>>  drivers/char/tpm/Makefile     |   1 +
>>  drivers/char/tpm/tpm_virtio.c | 460 ++++++++++++++++++++++++++++++++++
> 
> Maintainer entry?

Good call, I will add one.

Could you let me know what workflow would work best for you? I can direct
patches toward Chrome OS's kernel tree and only a Chrome OS list, then send them
your way only once they have been reviewed and accepted there. Or I can list one
or both of the linux-integrity@v.k.o and virtualization@l.l-f.o lists along with
a list for Chrome OS reviewers.

Either way, we'll want eyes from people who know virtio and from people who know
TPM on most changes.


> 
>>  3 files changed, 470 insertions(+)
>>  create mode 100644 drivers/char/tpm/tpm_virtio.c
>>
>> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>> index 536e55d3919f..8997060e248e 100644
>> --- a/drivers/char/tpm/Kconfig
>> +++ b/drivers/char/tpm/Kconfig
>> @@ -164,6 +164,15 @@ config TCG_VTPM_PROXY
>>  	  /dev/vtpmX and a server-side file descriptor on which the vTPM
>>  	  can receive commands.
>>  
>> +config TCG_VIRTIO_VTPM
>> +	tristate "Virtio vTPM"
>> +	depends on TCG_TPM
>> +	help
>> +	  This driver provides the guest kernel side of TPM over Virtio. If
>> +	  you are building Linux to run inside of a hypervisor that supports
>> +	  TPM over Virtio, say Yes and the virtualized TPM will be
>> +	  accessible from the guest.
>> +
>>  
>>  source "drivers/char/tpm/st33zp24/Kconfig"
>>  endif # TCG_TPM
>> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
>> index a01c4cab902a..4f5d1071257a 100644
>> --- a/drivers/char/tpm/Makefile
>> +++ b/drivers/char/tpm/Makefile
>> @@ -33,3 +33,4 @@ obj-$(CONFIG_TCG_TIS_ST33ZP24) += st33zp24/
>>  obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
>>  obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>> +obj-$(CONFIG_TCG_VIRTIO_VTPM) += tpm_virtio.o
>> diff --git a/drivers/char/tpm/tpm_virtio.c b/drivers/char/tpm/tpm_virtio.c
>> new file mode 100644
>> index 000000000000..f3239d983f18
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm_virtio.c
>> @@ -0,0 +1,460 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2019 Google Inc.
>> + *
>> + * Author: David Tolnay <dtolnay@gmail.com>
>> + *
>> + * ---
>> + *
>> + * Device driver for TPM over virtio.
>> + *
>> + * This driver employs a single virtio queue to handle both send and recv. TPM
>> + * commands are sent over virtio to the hypervisor during a TPM send operation
>> + * and responses are received over the same queue during a recv operation.
>> + *
>> + * The driver contains a single buffer that is the only buffer we ever place on
>> + * the virtio queue. Commands are copied from the caller's command buffer into
>> + * the driver's buffer before handing off to virtio, and responses are received
>> + * into the driver's buffer then copied into the caller's response buffer. This
>> + * allows us to be resilient to timeouts. When a send or recv operation times
>> + * out, the caller is free to destroy their buffer; we don't want the hypervisor
>> + * continuing to perform reads or writes against that destroyed buffer.
>> + *
>> + * This driver does not support concurrent send and recv operations. Mutual
>> + * exclusion is upheld by the tpm_mutex lock held in tpm-interface.c around the
>> + * calls to chip->ops->send and chip->ops->recv.
>> + *
>> + * The intended hypervisor-side implementation is as follows.
>> + *
>> + *     while true:
>> + *         await next virtio buffer.
>> + *         expect first descriptor in chain to be guest-to-host.
>> + *         read tpm command from that buffer.
>> + *         synchronously perform TPM work determined by the command.
>> + *         expect second descriptor in chain to be host-to-guest.
>> + *         write TPM response into that buffer.
>> + *         place buffer on virtio used queue indicating how many bytes written.
> 
> That's fine I think except generally it should be legal for guest
> to split each buffer to several segments.

Acknowledged. I will adjust this comment.

To clarify, this means the hypervisor will need to accept a single descriptor
chain consisting of one or more guest-to-host descriptors which together form
the command, followed by one or more host-to-guest descriptors into which the
response may be written. Is that what you had in mind?

TPM commands and responses are both capped at a moderate size (4096 bytes). With
that in mind, is it still necessary to allow split buffers? We won't be dealing
with multi-megabyte transfers.


>> + */
>> +
>> +#include <linux/virtio_config.h>
>> +
>> +#include "tpm.h"
>> +
>> +/*
>> + * Timeout duration when waiting on the hypervisor to complete its end of the
>> + * TPM operation. This timeout is relatively high because certain TPM operations
>> + * can take dozens of seconds.
>> + */
>> +#define TPM_VIRTIO_TIMEOUT (120 * HZ)
> 
> Should we read this from device? E.g. a busy hypervisor might
> take longer to respond ...

That's true. Do you have an example of an existing virtio driver that reads
timeout from the hypervisor?

To understand your perspective, do you see one of the following as being the
bigger advantage? -- either that we can use a timeout tighter than 120s for
hypervisors that believe they can respond quickly to any command, or that we can
relax the timeout beyond 120s for an especially overburdened hypervisor. The
first is nice because the caller in the guest will receive their error code
sooner in certain failure modes, but maybe that would be better addressed by
some other way of poking the host to find out whether it is still alive and
working. For the second, 120s is pretty generous and in our use case we would
just want to give up and retry much later at that point; I don't know how much
further it would be reasonable to grow a timeout.


>> +
>> +struct vtpm_device {
>> +	/*
>> +	 * Data structure for integration with the common code of the TPM driver
>> +	 * in tpm-chip.c.
>> +	 */
>> +	struct tpm_chip *chip;
>> +
>> +	/*
>> +	 * Virtio queue for sending TPM commands out of the virtual machine and
>> +	 * receiving TPM responses back from the hypervisor.
>> +	 */
>> +	struct virtqueue *vq;
>> +
>> +	/*
>> +	 * Completion that is notified when a virtio operation has been
>> +	 * fulfilled by the hypervisor.
>> +	 */
>> +	struct completion complete;
>> +
>> +	/*
>> +	 * Whether driver currently holds ownership of the virtqueue buffer.
>> +	 * When false, the hypervisor is in the process of reading or writing
>> +	 * the buffer and the driver must not touch it.
>> +	 */
>> +	bool driver_has_buffer;
>> +
>> +	/*
>> +	 * Whether during the most recent TPM operation, a virtqueue_kick failed
>> +	 * or a wait timed out.
>> +	 *
>> +	 * The next send or recv operation will attempt a kick upon seeing this
>> +	 * status. That should clear up the queue in the case that the
>> +	 * hypervisor became temporarily nonresponsive, such as by resource
>> +	 * exhaustion on the host. The extra kick enables recovery from kicks
>> +	 * going unnoticed by the hypervisor as well as recovery from virtio
>> +	 * callbacks going unnoticed by the guest kernel.
> 
> Well not necessarily. E.g. virtqueue_kick does not
> kick if hypervisor didn't enable notifications
> (e.g. with event idx they get disabled automatically).
> So it won't recover if hypervisor can discard
> kicks.
> 
> I think this comment needs clarification.

Makes sense. I didn't think to consider "hypervisor discards kicks" as a failure
mode. :) Would virtqueue_kick return false in that case? If so, needs_kick will
stay true and the kick will keep being retried on subsequent send/recv
operations until the hypervisor has enabled notifications again.

I will clarify the comment to touch on that situation.


>> +	 */
>> +	bool needs_kick;
>> +
>> +	/* Number of bytes available to read from the virtqueue buffer. */
>> +	unsigned int readable;
>> +
>> +	/*
>> +	 * Buffer in which all virtio transfers take place. Buffer size is the
>> +	 * maximum legal TPM command or response message size.
>> +	 */
>> +	u8 virtqueue_buffer[TPM_BUFSIZE];
>> +};
>> +
>> +/*
>> + * Wait for ownership of the virtqueue buffer.
>> + *
>> + * The why-string should begin with "waiting to..." or "waiting for..." with no
>> + * trailing newline. It will appear in log output.
>> + *
>> + * Returns zero for success, otherwise negative error.
>> + */
>> +static int vtpm_wait_for_buffer(struct vtpm_device *dev, const char *why)
>> +{
>> +	int ret;
>> +	bool did_kick;
>> +	struct tpm_chip *chip = dev->chip;
>> +	unsigned long deadline = jiffies + TPM_VIRTIO_TIMEOUT;
>> +
>> +	/* Kick queue if needed. */
>> +	if (dev->needs_kick) {
>> +		did_kick = virtqueue_kick(dev->vq);
>> +		if (!did_kick) {
>> +			dev_notice(&chip->dev, "kick failed; will retry\n");
>> +			return -EBUSY;
>> +		}
>> +		dev->needs_kick = false;
>> +	}
>> +
>> +	while (!dev->driver_has_buffer) {
>> +		unsigned long now = jiffies;
>> +
>> +		/* Check timeout, otherwise `deadline - now` may underflow. */
>> +		if time_after_eq(now, deadline) {
>> +			dev_warn(&chip->dev, "timed out %s\n", why);
>> +			dev->needs_kick = true;
>> +			return -ETIMEDOUT;
>> +		}
>> +
>> +		/*
>> +		 * Wait to be signaled by virtio callback.
>> +		 *
>> +		 * Positive ret is jiffies remaining until timeout when the
>> +		 * completion occurred, which means successful completion. Zero
>> +		 * ret is timeout. Negative ret is error.
>> +		 */
>> +		ret = wait_for_completion_killable_timeout(
>> +				&dev->complete, deadline - now);
>> +
>> +		/* Log if completion did not occur. */
>> +		if (ret == -ERESTARTSYS) {
>> +			/* Not a warning if it was simply interrupted. */
>> +			dev_dbg(&chip->dev, "interrupted %s\n", why);
>> +		} else if (ret == 0) {
>> +			dev_warn(&chip->dev, "timed out %s\n", why);
>> +			ret = -ETIMEDOUT;
> 
> Should we check NEEDS_RESET bit and try to reset the device?
> Or is that too drastic?

I'll let you make the call on whether we need a reset implemented. This driver
was initially based on the simple virtio-rng driver which doesn't reset (but nor
does it detect timeout). Let me know and I can give it a shot.


> 
>> +		} else if (ret < 0) {
>> +			dev_warn(&chip->dev, "failed while %s: error %d\n",
>> +					why, -ret);
>> +		}
>> +
>> +		/*
>> +		 * Return error if completion did not occur. Schedule kick to be
>> +		 * retried at the start of the next send/recv to help unblock
>> +		 * the queue.
>> +		 */
>> +		if (ret < 0) {
>> +			dev->needs_kick = true;
>> +			return ret;
>> +		}
>> +
>> +		/* Completion occurred. Expect response buffer back. */
>> +		if (virtqueue_get_buf(dev->vq, &dev->readable)) {
>> +			dev->driver_has_buffer = true;
>> +
>> +			if (dev->readable > TPM_BUFSIZE) {
>> +				dev_crit(&chip->dev,
>> +						"hypervisor bug: response exceeds max size, %u > %u\n",
>> +						dev->readable,
>> +						(unsigned int) TPM_BUFSIZE);
>> +				dev->readable = TPM_BUFSIZE;
>> +				return -EPROTO;
>> +			}
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int vtpm_op_send(struct tpm_chip *chip, u8 *caller_buf, size_t len)
>> +{
>> +	int ret;
>> +	bool did_kick;
>> +	struct scatterlist sg_outbuf, sg_inbuf;
>> +	struct scatterlist *sgs[2] = { &sg_outbuf, &sg_inbuf };
>> +	struct vtpm_device *dev = dev_get_drvdata(&chip->dev);
>> +	u8 *virtqueue_buf = dev->virtqueue_buffer;
>> +
>> +	dev_dbg(&chip->dev, __func__ " %zu bytes\n", len);
>> +
>> +	if (len > TPM_BUFSIZE) {
>> +		dev_err(&chip->dev,
>> +				"command is too long, %zu > %zu\n",
>> +				len, (size_t) TPM_BUFSIZE);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Wait until hypervisor relinquishes ownership of the virtqueue buffer.
>> +	 *
>> +	 * This may block if the previous recv operation timed out in the guest
>> +	 * kernel but is still being processed by the hypervisor. Also may block
>> +	 * if send operations are performed back-to-back, such as if something
>> +	 * in the caller failed in between a send and recv.
>> +	 *
>> +	 * During normal operation absent of any errors or timeouts, this does
>> +	 * not block.
>> +	 */
>> +	ret = vtpm_wait_for_buffer(dev, "waiting to begin send");
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Driver owns virtqueue buffer and may now write into it. */
>> +	memcpy(virtqueue_buf, caller_buf, len);
>> +
>> +	/*
>> +	 * Enqueue the virtqueue buffer once as outgoing virtio data (written by
>> +	 * the virtual machine and read by the hypervisor) and again as incoming
>> +	 * data (written by the hypervisor and read by the virtual machine).
>> +	 * This step moves ownership of the virtqueue buffer from driver to
>> +	 * hypervisor.
>> +	 *
>> +	 * Note that we don't know here how big of a buffer the caller will use
>> +	 * with their later call to recv. We allow the hypervisor to write up to
>> +	 * the TPM max message size. If the caller ends up using a smaller
>> +	 * buffer with recv that is too small to hold the entire response, the
>> +	 * recv will return an error. This conceivably breaks TPM
>> +	 * implementations that want to produce a different verbosity of
>> +	 * response depending on the receiver's buffer size.
>> +	 */
>> +	sg_init_one(&sg_outbuf, virtqueue_buf, len);
>> +	sg_init_one(&sg_inbuf, virtqueue_buf, TPM_BUFSIZE);
>> +	ret = virtqueue_add_sgs(dev->vq, sgs, 1, 1, virtqueue_buf, GFP_KERNEL);
>> +	if (ret) {
>> +		dev_err(&chip->dev, "failed virtqueue_add_sgs\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Kick the other end of the virtqueue after having added a buffer. */
>> +	did_kick = virtqueue_kick(dev->vq);
>> +	if (!did_kick) {
>> +		dev->needs_kick = true;
>> +		dev_notice(&chip->dev, "kick failed; will retry\n");
>> +
>> +		/*
>> +		 * We return 0 anyway because what the caller doesn't know can't
>> +		 * hurt them. They can call recv and it will retry the kick. If
>> +		 * that works, everything is fine.
>> +		 *
>> +		 * If the retry in recv fails too, they will get -EBUSY from
>> +		 * recv.
>> +		 */
>> +	}
>> +
>> +	/*
>> +	 * Hypervisor is now processing the TPM command asynchronously. It will
>> +	 * read the command from the output buffer and write the response into
>> +	 * the input buffer (which are the same buffer). When done, it will send
>> +	 * back the buffers over virtio and the driver's virtio callback will
>> +	 * complete dev->complete so that we know the response is ready to be
>> +	 * read.
>> +	 *
>> +	 * It is important to have copied data out of the caller's buffer into
>> +	 * the driver's virtqueue buffer because the caller is free to destroy
>> +	 * their buffer when this call returns. We can't avoid copying by
>> +	 * waiting here for the hypervisor to finish reading, because if that
>> +	 * wait times out, we return and the caller may destroy their buffer
>> +	 * while the hypervisor is continuing to read from it.
>> +	 */
>> +	dev->driver_has_buffer = false;
>> +	return 0;
>> +}
>> +
>> +static int vtpm_op_recv(struct tpm_chip *chip, u8 *caller_buf, size_t len)
>> +{
>> +	int ret;
>> +	struct vtpm_device *dev = dev_get_drvdata(&chip->dev);
>> +	u8 *virtqueue_buf = dev->virtqueue_buffer;
>> +
>> +	dev_dbg(&chip->dev, __func__ "\n");
>> +
>> +	/*
>> +	 * Wait until the virtqueue buffer is owned by the driver.
>> +	 *
>> +	 * This will usually block while the hypervisor finishes processing the
>> +	 * most recent TPM command.
>> +	 */
>> +	ret = vtpm_wait_for_buffer(dev, "waiting for TPM response");
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_dbg(&chip->dev, "received %u bytes\n", dev->readable);
>> +
>> +	if (dev->readable > len) {
>> +		dev_notice(&chip->dev,
>> +				"TPM response is bigger than receiver's buffer: %u > %zu\n",
>> +				dev->readable, len);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Copy response over to the caller. */
>> +	memcpy(caller_buf, virtqueue_buf, dev->readable);
>> +
>> +	return dev->readable;
>> +}
>> +
>> +static void vtpm_op_cancel(struct tpm_chip *chip)
>> +{
>> +	/*
>> +	 * Cancel is not called in this driver's use of tpm-interface.c. It may
>> +	 * be triggered through tpm-sysfs but that can be implemented as needed.
>> +	 * Be aware that tpm-sysfs performs cancellation without holding the
>> +	 * tpm_mutex that protects our send and recv operations, so a future
>> +	 * implementation will need to consider thread safety of concurrent
>> +	 * send/recv and cancel.
>> +	 */
>> +	dev_notice(&chip->dev, "cancellation is not implemented\n");
>> +}
>> +
>> +static u8 vtpm_op_status(struct tpm_chip *chip)
>> +{
>> +	/*
>> +	 * Status is for TPM drivers that want tpm-interface.c to poll for
>> +	 * completion before calling recv. Usually this is when the hardware
>> +	 * needs to be polled i.e. there is no other way for recv to block on
>> +	 * the TPM command completion.
>> +	 *
>> +	 * Polling goes until `(status & complete_mask) == complete_val`. This
>> +	 * driver defines both complete_mask and complete_val as 0 and blocks on
>> +	 * our own completion object in recv instead.
>> +	 */
>> +	return 0;
>> +}
>> +
>> +static const struct tpm_class_ops vtpm_ops = {
>> +	.flags = TPM_OPS_AUTO_STARTUP,
>> +	.send = vtpm_op_send,
>> +	.recv = vtpm_op_recv,
>> +	.cancel = vtpm_op_cancel,
>> +	.status = vtpm_op_status,
>> +	.req_complete_mask = 0,
>> +	.req_complete_val = 0,
>> +};
>> +
>> +static void vtpm_virtio_complete(struct virtqueue *vq)
>> +{
>> +	struct virtio_device *vdev = vq->vdev;
>> +	struct vtpm_device *dev = vdev->priv;
>> +
>> +	complete(&dev->complete);
>> +}
>> +
>> +static int vtpm_probe(struct virtio_device *vdev)
>> +{
>> +	int err;
>> +	struct vtpm_device *dev;
>> +	struct virtqueue *vq;
>> +	struct tpm_chip *chip;
>> +
>> +	dev_dbg(&vdev->dev, __func__ "\n");
>> +
>> +	dev = kzalloc(sizeof(struct vtpm_device), GFP_KERNEL);
>> +	if (!dev) {
>> +		err = -ENOMEM;
>> +		dev_err(&vdev->dev, "failed kzalloc\n");
>> +		goto err_dev_alloc;
>> +	}
>> +	vdev->priv = dev;
>> +
>> +	vq = virtio_find_single_vq(vdev, vtpm_virtio_complete, "vtpm");
>> +	if (IS_ERR(vq)) {
>> +		err = PTR_ERR(vq);
>> +		dev_err(&vdev->dev, "failed virtio_find_single_vq\n");
>> +		goto err_virtio_find;
>> +	}
>> +	dev->vq = vq;
>> +
>> +	chip = tpm_chip_alloc(&vdev->dev, &vtpm_ops);
>> +	if (IS_ERR(chip)) {
>> +		err = PTR_ERR(chip);
>> +		dev_err(&vdev->dev, "failed tpm_chip_alloc\n");
>> +		goto err_chip_alloc;
>> +	}
>> +	dev_set_drvdata(&chip->dev, dev);
>> +	chip->flags |= TPM_CHIP_FLAG_TPM2;
>> +	dev->chip = chip;
>> +
>> +	init_completion(&dev->complete);
>> +	dev->driver_has_buffer = true;
>> +	dev->needs_kick = false;
>> +	dev->readable = 0;
>> +
>> +	/*
>> +	 * Required in order to enable vq use in probe function for auto
>> +	 * startup.
>> +	 */
>> +	virtio_device_ready(vdev);
>> +
>> +	err = tpm_chip_register(dev->chip);
>> +	if (err) {
>> +		dev_err(&vdev->dev, "failed tpm_chip_register\n");
>> +		goto err_chip_register;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_chip_register:
>> +	put_device(&dev->chip->dev);
>> +err_chip_alloc:
>> +	vdev->config->del_vqs(vdev);
>> +err_virtio_find:
>> +	kfree(dev);
>> +err_dev_alloc:
>> +	return err;
>> +}
>> +
>> +static void vtpm_remove(struct virtio_device *vdev)
>> +{
>> +	struct vtpm_device *dev = vdev->priv;
>> +
>> +	/* Undo tpm_chip_register. */
>> +	tpm_chip_unregister(dev->chip);
>> +
>> +	/* Undo tpm_chip_alloc. */
>> +	put_device(&dev->chip->dev);
>> +
>> +	vdev->config->reset(vdev);
>> +	vdev->config->del_vqs(vdev);
>> +
>> +	kfree(dev);
>> +}
>> +
>> +#define VIRTIO_ID_TPM 31
>> +
>> +static struct virtio_device_id id_table[] = {
>> +	{
>> +		.device = VIRTIO_ID_TPM,
>> +		.vendor = VIRTIO_DEV_ANY_ID,
>> +	},
>> +	{},
>> +};
> 
> Let's write
> 
> static struct virtio_device_id id_table[] = {
>         { VIRTIO_ID_TPM, VIRTIO_DEV_ANY_ID },
>         { 0 },
> };
> 
> for consistency with other virtio devices.

Acknowledged, will do.


> 
>> +
>> +static struct virtio_driver vtpm_driver = {
>> +	.driver.name = KBUILD_MODNAME,
>> +	.driver.owner = THIS_MODULE,
>> +	.id_table = id_table,
>> +	.probe = vtpm_probe,
>> +	.remove = vtpm_remove,
> 
> Freeze/restore?

Good call. We don't need this for Chrome OS but I agree it should be in the
driver. I will provide a basic freeze/restore in line with what I see in
virtio-rng.

Thanks!


> 
> 
>> +};
>> +
>> +module_virtio_driver(vtpm_driver);
>> +
>> +MODULE_AUTHOR("David Tolnay (dtolnay@gmail.com)");
>> +MODULE_DESCRIPTION("Virtio vTPM Driver");
>> +MODULE_VERSION("1.0");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.20.1
> 

